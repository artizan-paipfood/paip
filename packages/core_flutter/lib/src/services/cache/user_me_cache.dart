import 'package:core_flutter/src/dependencies.dart';
import 'package:flutter/widgets.dart';

class UserMeCache {
  UserMeCache._();

  static late IAuthApi _authApi;

  static final ValueNotifier<UserMe?> _me = ValueNotifier(null);
  static ValueNotifier<UserMe?> get observer => _me;

  static UserMe? get me => _me.value;

  static bool isLoggedIn() => _me.value != null;

  static bool isLoggedOut() => !isLoggedIn();

  static Future<void> clear() async {
    _me.value = null;
  }

  static initialize(IAuthApi authApi) async {
    _authApi = authApi;
  }

  static Future<void> refresh() async {
    final response = await _authApi.me(userId: _me.value?.id ?? '', accessToken: '');
    _me.value = response;
  }
}
