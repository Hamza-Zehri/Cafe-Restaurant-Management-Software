import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_pos/core/utils/license_service.dart';

void main() {
  test('generateActivationKey matches keygen tool output', () {
    expect(
      LicenseService.generateActivationKey('2CEE-9255-DD28-3C40'),
      '813F-321B-0BB4-A8BB',
    );
  });

  test('verifyActivationKey accepts generated key and rejects wrong ones', () {
    const machineId = '2CEE-9255-DD28-3C40';
    final key = LicenseService.generateActivationKey(machineId);
    expect(LicenseService.verifyActivationKey(machineId, key), isTrue);
    expect(LicenseService.verifyActivationKey(machineId, '0000-0000-0000-0000'), isFalse);
    expect(
      LicenseService.verifyActivationKey('1111-2222-3333-4444', key),
      isFalse,
    );
  });

  test('generated key has short XXXX-XXXX-XXXX-XXXX format', () {
    final key = LicenseService.generateActivationKey('2CEE-9255-DD28-3C40');
    expect(key, matches(RegExp(r'^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}$')));
  });
}
