import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

// Secret shared with LicenseService (lib/core/utils/license_service.dart).
// Keep in sync! Changing it invalidates every generated key.
const _activationSecret = 'rp2::hamza::cafe-pos::hmac-v1';

void main(List<String> args) {
  if (args.isEmpty || args.first.trim().isEmpty) {
    stderr.writeln('Usage: dart run tools/keygen.dart <MACHINE_ID>');
    exit(64);
  }
  stdout.writeln(generateActivationKey(args.first));
}

/// Generates a compact 16-character activation key in the format
/// `XXXX-XXXX-XXXX-XXXX` (HMAC-SHA256 of the machine ID, first 8 bytes in hex).
String generateActivationKey(String machineId) {
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
