import 'dart:async';
import 'package:auth/auth.dart';
import 'package:auth/src/core/data/memory/auth_memory.dart';
import 'package:auth/src/core/data/services/device_id_service.dart';
import 'package:auth/src/core/domain/usecases/force_refresh_token_usecase.dart';
import 'package:auth/src/core/domain/usecases/get_refresh_token_cached_usecase.dart';
import 'package:auth/src/core/domain/usecases/save_refresh_token_cached_usecase.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';

class AuthSharedModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return [
      //* USECASES
      Bind.factory((i) => CacheServiceEncrypted(sharedPreferences: sharedPreferences, encryptKey: Env.encryptKey)),
      Bind.factory((i) => DeviceIdService(cache: i.get())),
      Bind.factory((i) => GetRefreshTokenCachedUsecase(cache: i.get())),
      Bind.factory((i) => SaveRefreshTokenCachedUsecase(cache: i.get())),
      Bind.factory((i) => ForceRefreshTokenUsecase(authApi: i.get())),
      Bind.factory(
        (i) => RefreshTokenUsecase(
          authApi: i.get(),
          authMemory: i.get(),
          getRefreshTokenCachedUsecase: i.get(),
          forceRefreshTokenUsecase: i.get(),
          saveRefreshTokenCachedUsecase: i.get(),
          encryptKey: Env.encryptKey,
        ),
      ),
      Bind.factory((i) => AuthApi(client: i.get())),

      //* MEMORY
      Bind.singleton((i) => AuthMemory.instance),
    ];
  }
}
