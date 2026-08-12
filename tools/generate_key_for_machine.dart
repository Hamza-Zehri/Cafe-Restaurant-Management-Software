import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

/// Generates a short activation key (`XXXX-XXXX-XXXX-XXXX`) for a machine ID.
/// Uses the same HMAC scheme as LicenseService.
///
/// Usage:
///   dart tools/generate_key_for_machine.dart <MACHINE_ID>
///
/// Example:
///   dart tools/generate_key_for_machine.dart 2CEE-9255-DD28-3C40
void main(List<String> args) {
  final machineId = args.isNotEmpty ? args[0].trim().toUpperCase() : '';
  if (machineId.isEmpty) {
    stdout.writeln('Usage: dart tools/generate_key_for_machine.dart <MACHINE_ID>');
    stdout.writeln('');
    stdout.writeln('Example:');
    stdout.writeln('  dart tools/generate_key_for_machine.dart 2CEE-9255-DD28-3C40');
    exit(1);
  }

  stdout.writeln('');
  stdout.writeln('Machine ID: $machineId');
  stdout.writeln('Activation Key:');
  stdout.writeln(generateActivationKey(machineId));
  stdout.writeln('');
}

String generateActivationKey(String machineId) {
  const secret = 'rp2::hamza::cafe-pos::hmac-v1';
  final digest = Hmac(sha256, utf8.encode(secret))
      .convert(utf8.encode(machineId))
      .bytes;
  final hex = digest
      .take(8)
      .map((b) => b.toRadixString(16).padLeft(2, '0'))
      .join()
      .toUpperCase();
  return '${hex.substring(0, 4)}-${hex.substring(4, 8)}-'
      '${hex.substring(8, 12)}-${hex.substring(12, 16)}';
}
