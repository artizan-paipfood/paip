import 'package:auth/auth.dart';
import 'package:auth/src/domain/models/refresh_token_model.dart';
import 'package:auth/src/domain/models/user_phone_model.dart';
import 'package:auth/src/memory/auth_memory.dart';
import 'package:auth/src/modules/auth_phone/services/auth_phone_service.dart';
import 'package:core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/ui.dart';

class AuthPhoneControllerConstants {
  AuthPhoneControllerConstants._();
  static Duration refreshTokenDuration = Duration(days: 365);
  static const String refreshTokenExpired = 'Refresh token expired';
  static const String invalidRefreshToken = 'Invalid refresh token';
}

class AuthPhoneViewmodel {
  final ICacheService cache;
  final EventBus eventBus;
  final IAuthApi authApi;
  final AuthMemory authMemory;
  final String encryptKey;
  final RefreshTokenUsecase refreshTokenUsecase;
  final AuthPhoneService service;
  AuthPhoneViewmodel({
    required this.cache,
    required this.eventBus,
    required this.authApi,
    required this.authMemory,
    required this.encryptKey,
    required this.refreshTokenUsecase,
    required this.service,
  });

  static final _box = 'paip_auth_phone_model';

  UserPhoneModel _model = UserPhoneModel(name: '', phoneDialCode: '', phoneNumber: '');

  EventBus get event => eventBus;

  UserPhoneModel get model => _model;

  Future<void> setUserData(UserPhoneModel model) async {
    _model = model;
    await cache.save(box: _box, data: model.toMap(), expiresIn: const Duration(minutes: 10));
  }

  Future<void> load() async {
    final data = await cache.get(box: _box);
    if (data == null) return;
    _model = UserPhoneModel.fromMap(data);
  }

  Future<AuthenticatedUser> refreshToken() async {
    return await refreshTokenUsecase();
  }

  Future<AuthenticatedUser> loginOrSignUp({required PhoneNumber phoneNumber, required String fullName}) async {
    final userExists = await authApi.userExistsByPhone(phoneNumber: phoneNumber);
    if (userExists) {
      return await _login(phoneNumber);
    } else {
      return await _signUp(phoneNumber: phoneNumber, fullName: fullName);
    }
  }

  Future<AuthenticatedUser> _login(PhoneNumber phoneNumber) async {
    final authenticatedUser = await authApi.loginByPhone(phoneNumber: phoneNumber, encryptKey: encryptKey);
    return await service.completeAuthenticationFlow(authenticatedUser: authenticatedUser);
  }

  Future<AuthenticatedUser> _signUp({required PhoneNumber phoneNumber, required String fullName}) async {
    final authenticatedUser = await authApi.signUpByPhone(phoneNumber: phoneNumber, encryptKey: encryptKey);
    return await service.completeAuthenticationFlow(authenticatedUser: authenticatedUser, fullName: fullName);
  }

  Future<void> logout(String accessToken) async {
    await authApi.logout(accessToken: accessToken);
    await _clearCachedData();
    authMemory.logout();
    eventBus.fire(UserLoggedOutEvent());
  }

  Future<void> _clearCachedData() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(RefreshTokenModel.prefsKey);
  }

  Future<UserEntity> updateNumberAndPassword({required PhoneNumber phoneNumber, required AuthenticatedUser authenticatedUser}) async {
    return await service.updateNumberAndPassword(phoneNumber: phoneNumber, authenticatedUser: authenticatedUser);
  }
}
