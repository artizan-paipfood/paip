import 'package:auth/auth.dart';
import 'package:auth/src/core/data/services/singletons/device_id.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';

class AuthSetup {
  AuthSetup._();

  static Future<void> setup({required Duration expiration}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final cache = CacheServiceEncrypted(sharedPreferences: sharedPreferences, encryptKey: Env.encryptKey);
    final client = ClientDio(baseOptions: PaipBaseOptions.supabase, interceptors: [SupabaseAuthInterceptor(dio: Dio())]);
    await AuthTokensCache.initialize(cacheService: cache, expiration: expiration);
    UserMe.initialize(AuthApi(client: client));
    DeviceId.initialize(cache);
  }
}
