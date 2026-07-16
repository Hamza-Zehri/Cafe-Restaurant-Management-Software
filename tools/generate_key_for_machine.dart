import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:pointycastle/export.dart';

void main(List<String> args) async {
  final machineId = args.isNotEmpty ? args[0] : '';
  if (machineId.isEmpty) {
    stdout.writeln('Usage: dart tools/generate_key_for_machine.dart <MACHINE_ID>');
    exit(1);
  }

  final random = _secureRandom();

  final generator = RSAKeyGenerator()
    ..init(ParametersWithRandom(
      RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 64),
      random,
    ));

  final pair = generator.generateKeyPair();
  final publicKey = pair.publicKey as RSAPublicKey;
  final privateKey = pair.privateKey as RSAPrivateKey;

  // Print the public key to update in LicenseService
  stdout.writeln('');
  stdout.writeln('=== UPDATE LicenseService with this public key ===');
  stdout.writeln("static final BigInt _publicModulus = BigInt.parse('${publicKey.modulus}');");
  stdout.writeln('static final BigInt _publicExponent = BigInt.from(${publicKey.exponent});');
  stdout.writeln('');

  // Save the private key
  final privPayload = {
    'n': privateKey.modulus.toString(),
    'd': privateKey.privateExponent.toString(),
    'p': privateKey.p.toString(),
    'q': privateKey.q.toString(),
  };
  final privJson = jsonEncode(privPayload);
  await File('tools/current_private_key.json').writeAsString(privJson);
  stdout.writeln('Private key saved to tools/current_private_key.json');

  // Sign the machine ID
  final signer = Signer('SHA-256/RSA')
    ..init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));
  final signature = signer.generateSignature(Uint8List.fromList(utf8.encode(machineId))) as RSASignature;
  final sigBytes = signature.bytes;

  // Encode as Base32
  const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';
  String encodeBase32(Uint8List bytes) {
    final out = StringBuffer();
    var buffer = 0;
    var bitsLeft = 0;
    for (final byte in bytes) {
      buffer = (buffer << 8) | byte;
      bitsLeft += 8;
      while (bitsLeft >= 5) {
        out.write(alphabet[(buffer >> (bitsLeft - 5)) & 31]);
        bitsLeft -= 5;
      }
    }
    if (bitsLeft > 0) {
      out.write(alphabet[(buffer << (5 - bitsLeft)) & 31]);
    }
    return out.toString();
  }

  final raw = encodeBase32(sigBytes);

  // Format in groups (XXXX-XXXX-XXXX-XXXX style, first 16 chars)
  final chunks = <String>[];
  for (var i = 0; i < raw.length; i += 4) {
    if (chunks.length >= 4) break;
    chunks.add(raw.substring(i, (i + 4).clamp(0, raw.length)));
  }
  final formatted = chunks.join('-');

  stdout.writeln('');
  stdout.writeln('Machine ID: $machineId');
  stdout.writeln('Activation Key: $formatted');
}

SecureRandom _secureRandom() {
  final random = Random.secure();
  final seed = Uint8List.fromList(List<int>.generate(32, (_) => random.nextInt(256)));
  return FortunaRandom()..seed(KeyParameter(seed));
}
