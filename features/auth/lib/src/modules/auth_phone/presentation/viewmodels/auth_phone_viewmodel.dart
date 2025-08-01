import 'package:auth/auth.dart';
import 'package:auth/src/core/domain/models/refresh_token_model.dart';
import 'package:auth/src/core/domain/models/user_phone_model.dart';
import 'package:auth/src/core/data/memory/auth_memory.dart';
import 'package:auth/src/modules/auth_phone/data/services/auth_phone_service.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';

class AuthPhoneControllerConstants {
  AuthPhoneControllerConstants._();
  static Duration refreshTokenDuration = Duration(days: 365);
  static Duration expireCacheDuration = Duration(minutes: 15);
  static const String refreshTokenExpired = 'Refresh token expired';
  static const String invalidRefreshToken = 'Invalid refresh token';
}

class AuthPhoneViewmodel {
  final ICacheService cache;
  final IAuthApi authApi;
  final AuthMemory authMemory;
  final String encryptKey;
  final RefreshTokenUsecase refreshTokenUsecase;
  final AuthPhoneService authPhoneService;
  AuthPhoneViewmodel({
    required this.cache,
    required this.authApi,
    required this.authMemory,
    required this.encryptKey,
    required this.refreshTokenUsecase,
    required this.authPhoneService,
  });

  static final _box = 'paip_auth_phone_model';

  UserPhoneModel _model = UserPhoneModel(name: '', phoneDialCode: '', phoneNumber: '');

  UserPhoneModel get model => _model;

  Future<void> setUserData(UserPhoneModel model) async {
    _model = model;
    await cache.save(box: _box, data: model.toMap(), expiresAt: DateTime.now().add(AuthPhoneControllerConstants.expireCacheDuration));
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
    return await authPhoneService.completeAuthenticationFlow(authenticatedUser: authenticatedUser);
  }

  Future<AuthenticatedUser> _signUp({required PhoneNumber phoneNumber, required String fullName}) async {
    final authenticatedUser = await authApi.signUpByPhone(phoneNumber: phoneNumber, encryptKey: encryptKey);
    return await authPhoneService.completeAuthenticationFlow(authenticatedUser: authenticatedUser, fullName: fullName);
  }

  Future<void> logout(String accessToken) async {
    await authApi.logout(accessToken: accessToken);
    await _clearCachedData();
    authMemory.logout();
    ModularEvent.fire(UserLoggedOutEvent());
  }

  Future<void> _clearCachedData() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(RefreshTokenModel.prefsKey);
  }

  Future<UserEntity> updateNumberAndPassword({required PhoneNumber phoneNumber, required AuthenticatedUser authenticatedUser}) async {
    return await authPhoneService.updateNumberAndPassword(phoneNumber: phoneNumber, authenticatedUser: authenticatedUser);
  }
}
