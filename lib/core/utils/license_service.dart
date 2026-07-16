import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';
import 'package:path/path.dart' as p;

import 'package:path_provider/path_provider.dart';

enum LicenseStatus { valid, missing, invalid, tampered, trial, trialExpired }

class LicenseService {
  static const _licenseFileName = 'license.dat';
  static const _trialFileName = 'trial.dat';
  static const _trialDays = 7;
  static const _base32Alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';
  static const _saltParts = ['rp', 'os', '-v2', ':', 'hamza', ':', 'license'];
  static String? _licenseDir;

  static Future<void> init() async {
    final sup = await getApplicationSupportDirectory();
    _licenseDir = p.join(sup.path, 'sysdata').replaceAll('\\', '/');
    await Directory(_licenseDir!).create(recursive: true);
    await _hidePath(_licenseDir!);
  }

  static Future<void> _hidePath(String path) async {
    if (!Platform.isWindows) return;
    try { await Process.run('attrib', ['+h', path]); } catch (_) {}
  }

  // Replace this generated development public key with your production public key
  // from `dart run tools/generate_keypair.dart` before shipping customer builds.
  static final BigInt _publicModulus = BigInt.parse(
    '18312461388406904034054358789206088085267195463515078393180730391506675075672945613359307431086630752687476936798697616725977778464939130198127261074540138210247132567195247815956882972353628096967910372555117842053595185311791525609587923967117443979539848185075656509444244715718352227626981636836673447277288575779125565064948612199285885839230628388530758426046829835224784504838757926846903011385362401339178472808491549916700031517068059324528222893792792617580288289637288788102667960105074116702071851677963829872146235232448431704154652260705173353514996691830416660081198848131677568297275219427532387976513',
  );
  static final BigInt _publicExponent = BigInt.from(65537);

  static String get _licensePath => p.join(_licenseDir!, _licenseFileName);
  static String get _salt => _saltParts.join();

  static Future<String> getMachineId() async {
    final parts = <String>[
      await _run('wmic', ['csproduct', 'get', 'UUID']),
      await _run('wmic', ['bios', 'get', 'serialnumber']),
      await _run('wmic', ['cpu', 'get', 'ProcessorId']),
      await _run('wmic', ['diskdrive', 'get', 'serialnumber']),
      await _run('reg', [
        'query',
        r'HKLM\SOFTWARE\Microsoft\Cryptography',
        '/v',
        'MachineGuid',
      ]),
      Platform.localHostname,
      Platform.environment['COMPUTERNAME'] ?? '',
      Platform.environment['USERNAME'] ?? '',
    ];

    final normalized = parts
        .map((p) => p.replaceAll(RegExp(r'\s+'), '').trim().toUpperCase())
        .where((p) => p.isNotEmpty)
        .join('|');
    final digest = sha256.convert(utf8.encode(normalized)).toString().toUpperCase();
    return '${digest.substring(0, 4)}-${digest.substring(4, 8)}-${digest.substring(8, 12)}-${digest.substring(12, 16)}';
  }

  static Future<LicenseStatus> validateLicense() async {
    // Check if activated
    final file = File(_licensePath);
    if (await file.exists()) {
      try {
        final package = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
        final payload = package['payload'] as String?;
        final hmacValue = package['hmac'] as String?;
        if (payload == null || hmacValue == null) return LicenseStatus.tampered;

        final machineId = await getMachineId();
        final keys = _deriveKeys(machineId);
        final expectedHmac = _hmacHex(base64Decode(payload), keys.hmacKey);
        if (!_constantTimeEquals(expectedHmac, hmacValue)) return LicenseStatus.tampered;

        final plain = _decrypt(base64Decode(payload), keys.aesKey, keys.iv);
        final data = jsonDecode(utf8.decode(plain)) as Map<String, dynamic>;
        final storedMachineId = data['machineId'] as String?;
        final activationKey = data['activationKey'] as String?;
        final timestamp = data['timestamp'] as String?;
        final checksum = data['checksum'] as String?;

        if (storedMachineId == null || activationKey == null || timestamp == null || checksum == null) {
          return LicenseStatus.tampered;
        }
        if (storedMachineId != machineId) return LicenseStatus.invalid;

        final expectedChecksum = sha256.convert(utf8.encode('$storedMachineId$activationKey$timestamp')).toString();
        if (!_constantTimeEquals(expectedChecksum, checksum)) return LicenseStatus.tampered;

        return verifyActivationKey(machineId, activationKey)
            ? LicenseStatus.valid
            : LicenseStatus.invalid;
      } catch (_) {
        return LicenseStatus.tampered;
      }
    }

    // No license file — check trial
    return _evalTrial();
  }

  static Future<LicenseStatus> _evalTrial() async {
    final trialFile = File(_trialPath);
    if (!await trialFile.exists()) return LicenseStatus.missing;
    try {
      final startStr = await trialFile.readAsString();
      final start = DateTime.tryParse(startStr.trim());
      if (start == null) return LicenseStatus.missing;
      final daysPassed = DateTime.now().difference(start).inDays;
      if (daysPassed >= _trialDays) return LicenseStatus.trialExpired;
      return LicenseStatus.trial;
    } catch (_) {
      return LicenseStatus.missing;
    }
  }

  static Future<void> startTrial() async {
    await Directory(_licenseDir!).create(recursive: true);
    await File(_trialPath).writeAsString(DateTime.now().toIso8601String());
    await _hidePath(_trialPath);
  }

  static Future<int> getTrialDaysLeft() async {
    final trialFile = File(_trialPath);
    if (!await trialFile.exists()) return _trialDays;
    try {
      final startStr = await trialFile.readAsString();
      final start = DateTime.tryParse(startStr.trim());
      if (start == null) return _trialDays;
      final left = _trialDays - DateTime.now().difference(start).inDays;
      return left < 0 ? 0 : left;
    } catch (_) {
      return _trialDays;
    }
  }

  static String get _trialPath => p.join(_licenseDir!, _trialFileName);

  static bool verifyActivationKey(String machineId, String activationKey) {
    try {
      final signature = _decodeBase32(activationKey);
      final signer = Signer('SHA-256/RSA')
        ..init(false, PublicKeyParameter<RSAPublicKey>(
          RSAPublicKey(_publicModulus, _publicExponent),
        ));
      return signer.verifySignature(
        Uint8List.fromList(utf8.encode(machineId)),
        RSASignature(signature),
      );
    } catch (_) {
      return false;
    }
  }

  static Future<bool> activate(String activationKey) async {
    final machineId = await getMachineId();
    if (!verifyActivationKey(machineId, activationKey)) return false;
    await storeLicense(machineId, activationKey);
    return true;
  }

  static Future<void> storeLicense(String machineId, String activationKey) async {
    await Directory(_licenseDir!).create(recursive: true);
    final timestamp = DateTime.now().toUtc().toIso8601String();
    final data = {
      'machineId': machineId,
      'activationKey': activationKey,
      'timestamp': timestamp,
      'checksum': sha256.convert(utf8.encode('$machineId$activationKey$timestamp')).toString(),
    };

    final keys = _deriveKeys(machineId);
    final encrypted = _encrypt(Uint8List.fromList(utf8.encode(jsonEncode(data))), keys.aesKey, keys.iv);
    final package = {
      'version': 1,
      'payload': base64Encode(encrypted),
      'hmac': _hmacHex(encrypted, keys.hmacKey),
    };
    await File(_licensePath).writeAsString(jsonEncode(package));
    await _hidePath(_licensePath);
  }

  static _LicenseKeys _deriveKeys(String machineId) {
    final seed = utf8.encode('$machineId|$_salt');
    final aesKey = Uint8List.fromList(sha256.convert(seed).bytes);
    final hmacKey = Uint8List.fromList(sha256.convert(utf8.encode('hmac|$machineId|$_salt')).bytes);
    final iv = Uint8List.fromList(sha256.convert(utf8.encode('iv|$_salt|$machineId')).bytes.sublist(0, 16));
    return _LicenseKeys(aesKey: aesKey, hmacKey: hmacKey, iv: iv);
  }

  static Uint8List _encrypt(Uint8List plain, Uint8List key, Uint8List iv) {
    final cipher = PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()))
      ..init(true, PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>(
        ParametersWithIV<KeyParameter>(KeyParameter(key), iv),
        null,
      ));
    return cipher.process(plain);
  }

  static Uint8List _decrypt(Uint8List cipherText, Uint8List key, Uint8List iv) {
    final cipher = PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()))
      ..init(false, PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>(
        ParametersWithIV<KeyParameter>(KeyParameter(key), iv),
        null,
      ));
    return cipher.process(cipherText);
  }

  static String _hmacHex(Uint8List bytes, Uint8List key) {
    final mac = Hmac(sha256, key).convert(bytes).toString();
    return mac;
  }

  static bool _constantTimeEquals(String a, String b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return diff == 0;
  }

  static String encodeActivationKey(Uint8List bytes) {
    final raw = _encodeBase32(bytes);
    final chunks = <String>[];
    for (var i = 0; i < raw.length; i += 5) {
      chunks.add(raw.substring(i, min(i + 5, raw.length)));
    }
    return chunks.join('-');
  }

  static String _encodeBase32(Uint8List bytes) {
    final out = StringBuffer();
    var buffer = 0;
    var bitsLeft = 0;
    for (final byte in bytes) {
      buffer = (buffer << 8) | byte;
      bitsLeft += 8;
      while (bitsLeft >= 5) {
        out.write(_base32Alphabet[(buffer >> (bitsLeft - 5)) & 31]);
        bitsLeft -= 5;
      }
    }
    if (bitsLeft > 0) {
      out.write(_base32Alphabet[(buffer << (5 - bitsLeft)) & 31]);
    }
    return out.toString();
  }

  static Uint8List _decodeBase32(String input) {
    final clean = input.replaceAll(RegExp(r'[^A-Z2-7]', caseSensitive: false), '').toUpperCase();
    final out = <int>[];
    var buffer = 0;
    var bitsLeft = 0;
    for (final code in clean.codeUnits) {
      final value = _base32Alphabet.indexOf(String.fromCharCode(code));
      if (value < 0) continue;
      buffer = (buffer << 5) | value;
      bitsLeft += 5;
      if (bitsLeft >= 8) {
        out.add((buffer >> (bitsLeft - 8)) & 0xFF);
        bitsLeft -= 8;
      }
    }
    return Uint8List.fromList(out);
  }

  static Future<String> _run(String executable, List<String> args) async {
    try {
      final result = await Process.run(executable, args).timeout(const Duration(seconds: 3));
      if (result.exitCode != 0) return '';
      return '${result.stdout}\n${result.stderr}';
    } catch (_) {
      return '';
    }
  }
}

class _LicenseKeys {
  const _LicenseKeys({required this.aesKey, required this.hmacKey, required this.iv});
  final Uint8List aesKey;
  final Uint8List hmacKey;
  final Uint8List iv;
}
