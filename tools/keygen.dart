import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

const _base32Alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';

void main(List<String> args) async {
  if (args.isEmpty || args.first.trim().isEmpty) {
    stderr.writeln('Usage: dart run tools/keygen.dart <MACHINE_ID>');
    exit(64);
  }

  final machineId = args.first.trim().toUpperCase();
  final privateKeyFile = File('tools/private_key.pem');
  if (!await privateKeyFile.exists()) {
    stderr.writeln('Missing tools/private_key.pem. Run: dart run tools/generate_keypair.dart');
    exit(66);
  }

  final privateKey = await _loadPrivateKey(privateKeyFile);
  final signer = Signer('SHA-256/RSA')
    ..init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));
  final signature = signer.generateSignature(Uint8List.fromList(utf8.encode(machineId))) as RSASignature;
  stdout.writeln(_formatBase32(signature.bytes));
}

Future<RSAPrivateKey> _loadPrivateKey(File file) async {
  final pem = await file.readAsString();
  final body = pem
      .replaceAll('-----BEGIN RSA PRIVATE KEY-----', '')
      .replaceAll('-----END RSA PRIVATE KEY-----', '')
      .replaceAll(RegExp(r'\s+'), '');
  final data = jsonDecode(utf8.decode(base64Decode(body))) as Map<String, dynamic>;
  return RSAPrivateKey(
    BigInt.parse(data['n'] as String),
    BigInt.parse(data['d'] as String),
    BigInt.parse(data['p'] as String),
    BigInt.parse(data['q'] as String),
  );
}

String _formatBase32(Uint8List bytes) {
  final raw = _encodeBase32(bytes);
  final chunks = <String>[];
  for (var i = 0; i < raw.length; i += 5) {
    chunks.add(raw.substring(i, min(i + 5, raw.length)));
  }
  return chunks.join('-');
}

String _encodeBase32(Uint8List bytes) {
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
