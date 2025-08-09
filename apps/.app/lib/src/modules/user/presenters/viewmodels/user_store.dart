import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app/src/modules/user/domain/dtos/user_viewmodel_dto.dart';
import 'package:app/src/modules/user/domain/usecases/address_user_usecase.dart';
import 'package:app/src/modules/user/domain/usecases/user_usecase.dart';
import 'package:app/src/modules/user/domain/dtos/user_dto.dart';
import 'package:app/src/modules/user/domain/enums/user_navigation_mode.dart';
import 'package:paipfood_package/paipfood_package.dart';

class UserStore extends ChangeNotifier {
  final AddressUserUsecase userAddressUsecase;
  final UserUsecase userUsecase;
  final ILocalStorage localStorage;

  UserStore({
    required this.userAddressUsecase,
    required this.userUsecase,
    required this.localStorage,
  });

  UserViewmodelCacheDto _dto = UserViewmodelCacheDto(userDto: UserDto.empty());

  String? get establishmentId => _dto.establishmentId;
  UserDto get userDto => _dto.userDto;
  UserNavigationMode get navigationMode => _dto.userNavigationMode;
  AddressEntity? get establishmentAdress => _dto.establishmentAdress;
  bool _isInitialized = false;
  CustomerModel buildCustomer() {
    return CustomerModel.fromUser(AuthNotifier.instance.auth.user!);
  }

  bool get phoneIsDifferent {
    final newPhone = Utils.onlyNumbersRgx("${userDto.phoneCountryCode}${userDto.phone}");
    final oldPhone = Utils.onlyNumbersRgx("${AuthNotifier.instance.auth.user!.phoneCountryCode}${AuthNotifier.instance.auth.user!.phone}");
    return newPhone != oldPhone;
  }

  void updateUserDto(UserDto userDto) {
    _dto = _dto.copyWith(userDto: userDto);
    _saveCache();
  }

  void initializeEstablishment(AddressEntity address) async {
    _dto = _dto.copyWith(establishmentId: address.establishmentId, establishmentAdress: address);
    _isInitialized = true;
    _saveCache();
  }

  Future<List<AddressEntity>> loadAdress() async {
    final result = await userAddressUsecase.getAll(AuthNotifier.instance.auth.user!.id!);
    AuthNotifier.instance.update(AuthNotifier.instance.auth.copyWith(user: AuthNotifier.instance.auth.user!.copyWith(addresses: result)));
    _saveCache();
    return result;
  }

  void reset() {
    _dto = UserViewmodelCacheDto(userDto: UserDto.empty());
    _saveCache();
  }

  Future<void> _saveCache() async {
    await localStorage.put(PreferencesModel.box, key: UserViewmodelCacheDto.key, value: _dto.toMap());
  }

  Future<UserViewmodelCacheDto?> loadCache() async {
    if (_isInitialized) return _dto;
    _isInitialized = true;
    final data = await localStorage.get(PreferencesModel.box, key: UserViewmodelCacheDto.key);
    if (data == null) return null;
    _dto = UserViewmodelCacheDto.fromMap(data);
    return null;
  }

  Future<void> navigateFinish(BuildContext context) async {
    notifyListeners();
    Future.delayed(1.seconds, () => reset());
    if (context.mounted) {
      Go.of(context).goNeglect(_dto.finishRoute);
    }
  }

  void setFinishRouteName(String route) {
    _dto = _dto.copyWith(finishRouteName: route);
    _saveCache();
  }

  void setNavigationMode(UserNavigationMode mode) {
    _dto = _dto.copyWith(userNavigationMode: mode);
    _saveCache();
  }

  void changeName(String name) {
    _dto = _dto.copyWith(userDto: userDto.copyWith(name: name));
    _saveCache();
  }

  void changePhone({required String phoneCountryCode, required String phone}) {
    _dto = _dto.copyWith(userDto: userDto.copyWith(phone: phone, phoneCountryCode: phoneCountryCode));
    _saveCache();
  }
}
