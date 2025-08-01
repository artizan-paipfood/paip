import 'dart:async';
import 'package:app/src/core/utils/routes.dart';
import 'package:app/src/modules/onboarding/onboarding_module.dart';
import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';

class AppModule extends EventModule {
  @override
  FutureOr<List<Bind<Object>>> binds() async {
    return [
      Bind.singleton((i) => ClientDio(baseOptions: PaipBaseOptions.supabase)),
    ];
  }

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Routes.onboardingModule, module: OnboardingModule()),
        ModuleRoute(Routes.authModule, module: AuthPhoneModule()),
      ];

  @override
  void listen() {}
}
