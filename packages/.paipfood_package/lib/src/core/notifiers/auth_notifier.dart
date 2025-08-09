import 'package:flutter/foundation.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AuthNotifier {
  static final AuthNotifier instance = AuthNotifier._internal();
  AuthNotifier._internal();

  static final ValueNotifier<AuthModel> authNotifer = ValueNotifier(AuthModel());

  late IRefreshToken refreshTokenService;

  Future<void> initialize(IRefreshToken refreshTokenService) async {
    this.refreshTokenService = refreshTokenService;
  }

  String get accessToken => authNotifer.value.accessToken ?? 'undefined';

  AuthModel get auth => authNotifer.value;
  Future<AuthModel> login(AuthModel auth) async {
    final result = await refreshTokenService.login(auth);
    authNotifer.value = result;
    return result;
  }

  void update(AuthModel auth) {
    authNotifer.value = auth;
  }

  Future<void> logout() async {
    await refreshTokenService.logout();
    authNotifer.value = AuthModel();
  }

  Future<AuthModel?> refreshToken() async {
    try {
      final auth = await refreshTokenService.refreshToken();
      update(auth);
      return auth;
    } catch (e) {
      return null;
    }
  }
}
