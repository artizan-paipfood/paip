import 'package:flutter_test/flutter_test.dart';
import 'package:manager/src/modules/config/domain/dtos/user_preferences_dto.dart';

void main() {
  group('USER  PREFERENCES DTO', () {
    test('Deve retornar ao contrario de isPrimaryTerminal', () {
      final dto = UserPreferencesDto(
        handMode: HandMode.leftHanded,
        isPhoneRequiredForGuestClient: true,
        isPrimaryTerminal: true,
      );
      expect(dto.isNotPrimaryTerminal, !dto.isPrimaryTerminal);
    });
  });
}
