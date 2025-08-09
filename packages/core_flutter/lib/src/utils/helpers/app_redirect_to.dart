import 'package:core_flutter/core_flutter.dart';

class AppRedirectTo {
  static const String _boxName = 'app_redirect_temp';
  static late ICacheService _cache;
  static late Duration _expiresAt;

  static void initialize({required ICacheService cacheService, required Duration expiresAt}) {
    _cache = cacheService;
    _expiresAt = expiresAt;
  }

  static void set(String redirectTo) {
    _cache.save(box: _boxName, data: {'redirectTo': redirectTo}, expiresAt: DateTime.now().add(_expiresAt));
  }

  static Future<String?> get(GoRouterState state) async {
    final data = await _cache.get(box: _boxName);
    if (data == null) return null;
    final redirect = data['redirectTo'] as String?;
    if (redirect == null) return null;
    final isNamed = !redirect.contains('/');
    if (isNamed) {
      return state.namedLocation(redirect);
    } else {
      return redirect;
    }
  }
}
