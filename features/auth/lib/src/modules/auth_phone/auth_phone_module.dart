import 'dart:async';
import 'package:auth/auth.dart';
import 'package:auth/src/modules/auth_phone/auth_core_binds_module.dart';
import 'package:auth/src/modules/auth_phone/domain/usecase/update_user_phone_usecase.dart';
import 'package:auth/src/modules/auth_phone/presentation/pages/user_name_page.dart';
import 'package:auth/src/modules/auth_phone/presentation/viewmodels/auth_phone_viewmodel.dart';
import 'package:auth/src/modules/auth_phone/presentation/pages/phone_confirm_page.dart';
import 'package:auth/src/modules/auth_phone/presentation/pages/phone_page.dart';
import 'package:auth/src/modules/auth_phone/utils/routes.dart';
import 'package:core_flutter/core_flutter.dart';

class AuthPhoneModule extends EventModule {
  @override
  FutureOr<List<Module>> imports() async {
    return [AuthCoreBindsModule()];
  }

  @override
  FutureOr<List<Bind<Object>>> binds() async {
    return [
      Bind.singleton((i) => UpdateUserPhoneUsecase(
            authApi: i.get(),
            encryptKey: Env.encryptKey,
          )),
      Bind.singleton((i) => SilentAuthentication(
            authApi: i.get(),
            cache: i.get(),
            encryptKey: Env.encryptKey,
            expiresIn: Duration(days: 365),
          )),
      Bind.singleton((i) => AuthPhoneViewmodel(
            cache: i.get(),
            silentAuthentication: i.get(),
            updateUserPhoneUsecase: i.get(),
          )),
    ];
  }

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

  @override
  void listen() {
    on<RequestSilentAuthentication>(
      (event, context) async {
        ModularLoader.show();
        final me = await Modular.get<SilentAuthentication>().auth();
        ModularLoader.hide();
        if (me != null) context?.go(event.redirectTo);
      },
    );
  }
}
