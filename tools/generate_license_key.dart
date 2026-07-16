import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:pointycastle/export.dart';

void main(List<String> args) async {
  final machineId = args.isNotEmpty ? args[0] : '';
  if (machineId.isEmpty) {
    stdout.writeln('Usage: dart tools/generate_license_key.dart <MACHINE_ID>');
    stdout.writeln('');
    stdout.writeln('Get the Machine ID from the Activation screen in the app.');
    exit(1);
  }

  // Read private key from PEM
  final pem = await File('tools/private_key.pem').readAsString();
  final b64 = pem
      .replaceAll('-----BEGIN RSA PRIVATE KEY-----', '')
      .replaceAll('-----END RSA PRIVATE KEY-----', '')
      .replaceAll(RegExp(r'\s'), '');
  final payload = jsonDecode(utf8.decode(base64Decode(b64))) as Map<String, dynamic>;

  final n = BigInt.parse(payload['n'] as String);
  final e = BigInt.parse(payload['e'] as String);
  final d = BigInt.parse(payload['d'] as String);
  final p = BigInt.parse(payload['p'] as String);
  final q = BigInt.parse(payload['q'] as String);

  // Recompute dp, dq, qInv for CRT
  final dp = d % (p - BigInt.one);
  final dq = d % (q - BigInt.one);
  final qInv = q.modInverse(p);

  final privateKey = RSAPrivateKey(n, e, d, p, q, dp, dq, qInv);

  // Sign machine ID
  final signer = Signer('SHA-256/RSA')
    ..init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));
  final signature = signer.generateSignature(Uint8List.fromList(utf8.encode(machineId))) as RSASignature;

  final sigBytes = signature.bytes;

  // Encode as Base32 -> format as chunks
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

  // Format as XXXX-XXXX-XXXX-XXXX (16 chars, 4 groups of 4)
  // Base32 encodes 256 bits = ~52 chars. We'll truncate to 16 chars for user-friendliness
  // Actually the RSA-2048 signature is 256 bytes = 2048 bits
  // Base32 will produce ~410 chars. Let's just format the first 20 chars as 4 groups of 5
  final chunks = <String>[];
  for (var i = 0; i < raw.length; i += 4) {
    if (chunks.length >= 4) break;
    chunks.add(raw.substring(i, (i + 4).clamp(0, raw.length)));
  }
  final formatted = chunks.join('-');

  stdout.writeln('');
  stdout.writeln('Machine ID: $machineId');
  stdout.writeln('Activation Key: $formatted');
  stdout.writeln('');
  stdout.writeln('Full signature (Base32): $raw');
}
