import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:manager/src/modules/config/domain/dtos/user_preferences_dto.dart';
import 'package:manager/src/modules/config/presenters/viewmodels/user_preferences_viewmode.dart';
import 'package:paipfood_package/paipfood_package.dart';

class MockLocalStorage extends Mock implements ILocalStorage {}

void main() {
  late UserPreferencesViewmodel viewmodel;
  late ILocalStorage localStorage;

  setUp(() {
    localStorage = MockLocalStorage();
    when(() => localStorage.get(PreferencesModel.box, key: UserPreferencesDto.box)).thenAnswer((_) async => null);
    viewmodel = UserPreferencesViewmodel(localStorage: localStorage);
  });

  group('USER PREFERENCES VIEWMODEL', () {
    test('initialize() Ao inicializar a classe o methodo initialize deve ser chamado', () {
      verify(() => localStorage.get(PreferencesModel.box, key: UserPreferencesDto.box)).called(1);
    });

    test('edit() Após editar o getter de preferences deve retorna diferente', () {
      final userPreferencesDefault = viewmodel.userPreferences.copyWith();
      viewmodel.edit(userPreferencesDefault.copyWith(
        handMode: HandMode.leftHanded,
        isPhoneRequiredForGuestClient: false,
        isPrimaryTerminal: true,
        initialOrderCount: 400,
      ));
      expect(viewmodel.userPreferences, isNot(userPreferencesDefault));
    });

    test('save() Ao salvar deve salvar no local storage', () async {
      final userPreferencesDefault = viewmodel.userPreferences.copyWith();
      when(() => localStorage.put(PreferencesModel.box, key: UserPreferencesDto.box, value: userPreferencesDefault.toMap())).thenAnswer((_) async {});
      await viewmodel.save();
      verify(() => localStorage.put(PreferencesModel.box, key: UserPreferencesDto.box, value: userPreferencesDefault.toMap())).called(1);
    });

    test('Ao inicializar se no local storage estiver nulo o getter tem que retornar o padrão', () {
      final userPreferencesDefault = viewmodel.userPreferences.copyWith();
      when(() => localStorage.get(PreferencesModel.box, key: UserPreferencesDto.box)).thenAnswer((_) async => null);
      viewmodel.initialize();
      expect(viewmodel.userPreferences, userPreferencesDefault);
    });

    test('Ao inicializar se estiver ocorrido uma alteração anteriormente o userPreferences tem que retornar o valor salvo', () {
      final userPreferencesDefault = viewmodel.userPreferences.copyWith();
      final userPreferencesEdited = userPreferencesDefault.copyWith(
        handMode: HandMode.leftHanded,
        isPhoneRequiredForGuestClient: false,
        isPrimaryTerminal: true,
        initialOrderCount: 400,
      );
      viewmodel.edit(userPreferencesEdited);
      when(() => localStorage.get(PreferencesModel.box, key: UserPreferencesDto.box)).thenAnswer((_) async => userPreferencesEdited.toMap());
      viewmodel.initialize();
      expect(viewmodel.userPreferences, isNot(userPreferencesDefault));
    });
  });
}
