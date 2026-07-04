import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

void main() async {
  await Directory('tools').create(recursive: true);

  final generator = RSAKeyGenerator()
    ..init(ParametersWithRandom(
      RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 64),
      _secureRandom(),
    ));

  final pair = generator.generateKeyPair();
  final publicKey = pair.publicKey as RSAPublicKey;
  final privateKey = pair.privateKey as RSAPrivateKey;

  final privatePayload = {
    'n': privateKey.n.toString(),
    'e': publicKey.exponent.toString(),
    'd': privateKey.privateExponent.toString(),
    'p': privateKey.p.toString(),
    'q': privateKey.q.toString(),
  };

  final encoded = base64Encode(utf8.encode(jsonEncode(privatePayload)));
  final pem = StringBuffer()
    ..writeln('-----BEGIN RSA PRIVATE KEY-----');
  for (var i = 0; i < encoded.length; i += 64) {
    pem.writeln(encoded.substring(i, min(i + 64, encoded.length)));
  }
  pem.writeln('-----END RSA PRIVATE KEY-----');

  await File('tools/private_key.pem').writeAsString(pem.toString());

  stdout.writeln('Generated tools/private_key.pem');
  stdout.writeln('');
  stdout.writeln('Paste these values into LicenseService before shipping:');
  stdout.writeln("static final BigInt _publicModulus = BigInt.parse('${publicKey.modulus}');");
  stdout.writeln('static final BigInt _publicExponent = BigInt.from(${publicKey.exponent});');
}

SecureRandom _secureRandom() {
  final random = Random.secure();
  final seed = Uint8List.fromList(List<int>.generate(32, (_) => random.nextInt(256)));
  return FortunaRandom()..seed(KeyParameter(seed));
}
