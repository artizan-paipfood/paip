import 'dart:async';
import 'package:auth/auth.dart';
import 'package:auth/src/memory/auth_memory.dart';
import 'package:auth/src/domain/usecases/force_refresh_token_usecase.dart';
import 'package:auth/src/domain/usecases/get_refresh_token_cached_usecase.dart';
import 'package:auth/src/domain/usecases/save_refresh_token_cached_usecase.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';

class AuthModule extends Module {
  final EventBus eventBus;
  final String jwtSecret;
  final String encryptKey;

  AuthModule({
    required this.eventBus,
    required this.jwtSecret,
    required this.encryptKey,
  });
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        //* USECASES
        Bind.factory((i) => GetRefreshTokenCachedUsecase()),
        Bind.factory((i) => CacheService(sharedPreferences: i.get())),
        Bind.factory((i) => SaveRefreshTokenCachedUsecase()),
        Bind.factory((i) => ForceRefreshTokenUsecase(authApi: i.get())),
        Bind.factory(
          (i) => RefreshTokenUsecase(
            authApi: i.get(),
            authMemory: i.get(),
            eventBus: eventBus,
            getRefreshTokenCachedUsecase: i.get(),
            forceRefreshTokenUsecase: i.get(),
            saveRefreshTokenCachedUsecase: i.get(),
            encryptKey: encryptKey,
            jwtSecret: jwtSecret,
          ),
        ),
        Bind.factory((i) => AuthApi(client: i.get())),

        //* MEMORY
        Bind.singleton((i) => AuthMemory.instance),
      ];
}
