import 'package:auth/src/core/data/services/singletons/auth_tokens_cache.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

class UserMe {
  UserMe._();

  static late IAuthApi _authApi;

  static final ValueNotifier<UserMeModel?> _me = ValueNotifier(null);
  static ValueNotifier<UserMeModel?> get observer => _me;

  static UserMeModel? get me => _me.value;

  static bool isLoggedIn() => _me.value != null;

  static bool isLoggedOut() => !isLoggedIn();

  static Future<void> logout() async {
    _me.value = null;
    await AuthTokensCache.clear();
  }

  static void initialize(IAuthApi authApi) {
    _authApi = authApi;
  }

  static Future<void> login(String userId) async {
    final tokens = await AuthTokensCache.getTokens();
    if (tokens == null) throw Exception('No tokens found');
    await refresh(userId);
  }

  static Future<void> refresh(String userId) async {
    final response = await _authApi.me(userId: userId);
    _me.value = response;
  }
}
