import 'dart:async';
import 'package:auth/auth.dart';
import 'package:auth/src/auth_module.dart';
import 'package:auth/src/modules/auth_phone/presentation/viewmodels/auth_phone_viewmodel.dart';
import 'package:auth/src/modules/auth_phone/presentation/pages/phone_confirm_page.dart';
import 'package:auth/src/modules/auth_phone/presentation/pages/phone_page.dart';
import 'package:auth/src/modules/auth_phone/services/auth_phone_service.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';

class AuthPhoneModule extends Module {
  final String jwtSecret;
  final String encryptKey;
  final EventBus eventBus;
  final String modulePath;
  AuthPhoneModule({required this.jwtSecret, required this.encryptKey, required this.eventBus, required this.modulePath});

  @override
  FutureOr<List<Module>> imports() {
    return [
      AuthModule(eventBus: eventBus, jwtSecret: jwtSecret, encryptKey: encryptKey),
    ];
  }

  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.singleton((i) => AuthPhoneRoute(modulePath)),
        Bind.singleton((i) => AuthPhoneService(
              saveRefreshTokenCachedUsecase: i.get(),
              authApi: i.get(),
              authMemory: i.get(),
              jwtSecret: jwtSecret,
              encryptKey: encryptKey,
            )),
        Bind.singleton((i) => AuthPhoneViewmodel(
              service: i.get(),
              authMemory: i.get(),
              authApi: i.get(),
              eventBus: eventBus,
              refreshTokenUsecase: i.get(),
              cache: i.get(),
              encryptKey: encryptKey,
            )),
      ];

  @override
  List<ModularRoute> get routes {
    final r = AuthPhoneRoute(modulePath);
    return [
      ChildRoute(r.userNameRelative, child: (context, state) => AuthUserNamePage()),
      ChildRoute(r.phoneRelative, child: (context, state) => AuthPhonePage()),
      ChildRoute(r.phoneConfirmRelative, child: (context, state) => AuthPhoneConfirmPage()),
    ];
  }
}
