import 'dart:convert';
import 'dart:io';
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
  // Secret shared with the key generators (tools/keygen.dart). Keep in sync!
  static const _activationSecret = 'rp2::hamza::cafe-pos::hmac-v1';
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
    try {
      await Process.run('attrib', ['+h', path]).timeout(const Duration(seconds: 3));
    } catch (_) {}
  }

  static String get _licensePath => p.join(_licenseDir!, _licenseFileName);
  static String get _salt => _saltParts.join();

  static Future<String> getMachineId() async {
    // IMPORTANT: only stable hardware / OS-install identifiers are used.
    // Hostname, COMPUTERNAME, USERNAME and attached-disk serials are excluded
    // because they change when the PC is renamed, a different user logs in, or
    // a USB drive is plugged in — which previously invalidated activations.
    final parts = <String>[
      await _run('wmic', ['csproduct', 'get', 'UUID']),
      await _run('wmic', ['bios', 'get', 'serialnumber']),
      await _run('wmic', ['cpu', 'get', 'ProcessorId']),
      await _run('reg', [
        'query',
        r'HKLM\SOFTWARE\Microsoft\Cryptography',
        '/v',
        'MachineGuid',
      ]),
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

  /// Generates a compact 16-character activation key in the format
  /// `XXXX-XXXX-XXXX-XXXX` (HMAC-SHA256 of the machine ID, first 8 bytes in hex).
  static String generateActivationKey(String machineId) {
    final digest = Hmac(sha256, utf8.encode(_activationSecret))
        .convert(utf8.encode(machineId.trim().toUpperCase()))
        .bytes;
    final hex = digest
        .take(8)
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join()
        .toUpperCase();
    return '${hex.substring(0, 4)}-${hex.substring(4, 8)}-'
        '${hex.substring(8, 12)}-${hex.substring(12, 16)}';
  }

  static bool verifyActivationKey(String machineId, String activationKey) {
    final normalized = activationKey
        .replaceAll(RegExp(r'[^A-F0-9]', caseSensitive: false), '')
        .toUpperCase();
    return _constantTimeEquals(
      generateActivationKey(machineId).replaceAll('-', ''),
      normalized,
    );
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
