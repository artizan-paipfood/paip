import 'package:flutter/foundation.dart';
import 'package:manager/src/modules/config/domain/dtos/user_preferences_dto.dart';
import 'package:paipfood_package/paipfood_package.dart';

class UserPreferencesViewmodel extends ChangeNotifier {
  final ILocalStorage localStorage;
  UserPreferencesViewmodel({required this.localStorage}) {
    initialize();
  }

  UserPreferencesDto _userPreferences = UserPreferencesDto(
    handMode: HandMode.rightHanded,
    isPhoneRequiredForGuestClient: true,
    isPrimaryTerminal: true,
  );

  UserPreferencesDto get userPreferences => _userPreferences;

  @visibleForTesting
  Future<void> initialize() async {
    final data = await localStorage.get(PreferencesModel.box, key: UserPreferencesDto.box);

    if (data == null) return;

    _userPreferences = UserPreferencesDto.fromMap(data);
    notifyListeners();
  }

  void edit(UserPreferencesDto userPreferences) {
    _userPreferences = userPreferences;
    notifyListeners();
  }

  Future<void> save() async {
    await localStorage.put(PreferencesModel.box, key: UserPreferencesDto.box, value: _userPreferences.toMap());
  }
}
