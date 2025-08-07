import 'dart:async';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';

class AuthCoreBindsModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return [
      Bind.singleton<ICacheService>((i) => CacheServiceEncrypted(sharedPreferences: sharedPreferences, encryptKey: Env.encryptKey)),
      Bind.factory<IAuthApi>((i) => AuthApi(client: i.get())),
    ];
  }
}
