import 'dart:async';
import 'package:auth/auth.dart';
import 'package:auth/src/core/auth_shared_module.dart';
import 'package:auth/src/modules/auth_phone/presentation/viewmodels/auth_phone_viewmodel.dart';
import 'package:auth/src/modules/auth_phone/presentation/pages/phone_confirm_page.dart';
import 'package:auth/src/modules/auth_phone/presentation/pages/phone_page.dart';
import 'package:auth/src/modules/auth_phone/data/services/auth_phone_service.dart';
import 'package:auth/src/modules/auth_phone/utils/routes.dart';
import 'package:core_flutter/core_flutter.dart';

class AuthPhoneModule extends Module {
  @override
  FutureOr<List<Module>> imports() async {
    await SharedPreferences.getInstance().then((value) => value.clear());
    return [AuthSharedModule()];
  }

  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.singleton((i) => AuthPhoneService(
              saveRefreshTokenCachedUsecase: i.get(),
              authApi: i.get(),
              authMemory: i.get(),
              encryptKey: Env.encryptKey,
              deviceIdService: i.get(),
            )),
        Bind.singleton((i) => AuthPhoneViewmodel(
              authPhoneService: i.get(),
              authMemory: i.get(),
              authApi: i.get(),
              refreshTokenUsecase: i.get(),
              cache: i.get(),
              encryptKey: Env.encryptKey,
            )),
      ];

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        Routes.userNameRelative,
        name: Routes.userNameNamed,
        child: (context, state) => AuthUserNamePage(),
      ),
      ChildRoute(
        Routes.phoneRelative,
        name: Routes.phoneNamed,
        child: (context, state) => AuthPhonePage(),
      ),
      ChildRoute(
        Routes.phoneConfirmRelative,
        name: Routes.phoneConfirmNamed,
        child: (context, state) => AuthPhoneConfirmPage(),
      ),
    ];
  }
}
