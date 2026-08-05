import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:pointycastle/export.dart';

/// Generates a full activation key for a given machine ID using the saved
/// private key in tools/current_private_key.json.
///
/// Usage:
///   dart tools/generate_key_for_machine.dart <MACHINE_ID>
///
/// Example:
///   dart tools/generate_key_for_machine.dart 2CEE-9255-DD28-3C40
void main(List<String> args) async {
  final machineId = args.isNotEmpty ? args[0] : '';
  if (machineId.isEmpty) {
    stdout.writeln('Usage: dart tools/generate_key_for_machine.dart <MACHINE_ID>');
    stdout.writeln('');
    stdout.writeln('Example:');
    stdout.writeln('  dart tools/generate_key_for_machine.dart 2CEE-9255-DD28-3C40');
    exit(1);
  }

  // Load the saved private key (must match the public key in LicenseService)
  final privFile = File('tools/current_private_key.json');
  if (!await privFile.exists()) {
    stdout.writeln('ERROR: tools/current_private_key.json not found.');
    stdout.writeln('Run dart tools/generate_license_key.dart first to generate a keypair.');
    exit(1);
  }

  final privMap = jsonDecode(await privFile.readAsString()) as Map<String, dynamic>;
  final privateKey = RSAPrivateKey(
    BigInt.parse(privMap['n'] as String),
    BigInt.parse(privMap['d'] as String),
    BigInt.parse(privMap['p'] as String),
    BigInt.parse(privMap['q'] as String),
  );

  // Sign the machine ID with SHA-256/RSA (same as LicenseService.verifyActivationKey)
  final signer = Signer('SHA-256/RSA')
    ..init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));
  final signature = signer.generateSignature(Uint8List.fromList(utf8.encode(machineId))) as RSASignature;
  final sigBytes = signature.bytes;

  // Base32 encode (same as LicenseService._encodeBase32)
  const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';
  final out = StringBuffer();
  var buffer = 0;
  var bitsLeft = 0;
  for (final byte in sigBytes) {
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
  final raw = out.toString();

  // Format in groups of 5 (same as LicenseService.encodeActivationKey)
  final chunks = <String>[];
  for (var i = 0; i < raw.length; i += 5) {
    chunks.add(raw.substring(i, (i + 5).clamp(0, raw.length)));
  }
  final formatted = chunks.join('-');

  stdout.writeln('');
  stdout.writeln('Machine ID: $machineId');
  stdout.writeln('Activation Key:');
  stdout.writeln(formatted);
  stdout.writeln('');
}
