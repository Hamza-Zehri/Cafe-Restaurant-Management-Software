import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';

void main() async {
  final parts = <String>[
    await _run('wmic', ['csproduct', 'get', 'UUID']),
    await _run('wmic', ['bios', 'get', 'serialnumber']),
    await _run('wmic', ['cpu', 'get', 'ProcessorId']),
    await _run('wmic', ['diskdrive', 'get', 'serialnumber']),
    await _run('reg', ['query', r'HKLM\SOFTWARE\Microsoft\Cryptography', '/v', 'MachineGuid']),
    Platform.localHostname,
    Platform.environment['COMPUTERNAME'] ?? '',
    Platform.environment['USERNAME'] ?? '',
  ];

  final normalized = parts
      .map((p) => p.replaceAll(RegExp(r'\s+'), '').trim().toUpperCase())
      .where((p) => p.isNotEmpty)
      .join('|');
  final digest = sha256.convert(utf8.encode(normalized)).toString().toUpperCase();
  final id = '${digest.substring(0, 4)}-${digest.substring(4, 8)}-${digest.substring(8, 12)}-${digest.substring(12, 16)}';
  stdout.writeln('Machine ID: $id');
}

Future<String> _run(String executable, List<String> args) async {
  try {
    final result = await Process.run(executable, args).timeout(const Duration(seconds: 3));
    if (result.exitCode != 0) return '';
    return '${result.stdout}\n${result.stderr}';
  } catch (_) {
    return '';
  }
}
