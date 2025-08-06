import 'dart:async';
import 'package:address/address.dart';
import 'package:app/i18n/gen/strings.g.dart';
import 'package:app/src/core/utils/routes.dart';
import 'package:app/src/modules/onboarding/onboarding_module.dart';
import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:ui/ui.dart';

class AppModule extends EventModule {
  @override
  FutureOr<List<Bind<Object>>> binds() async {
    return [
      Bind.singleton((i) => ClientDio(baseOptions: PaipBaseOptions.paipApi), key: PaipBindKey.paipApi),
      Bind.singleton((i) => ClientDio(baseOptions: PaipBaseOptions.supabase)),
    ];
  }

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Routes.onboardingModule, module: OnboardingModule()),
        ModuleRoute(Routes.authModule, module: AuthPhoneModule()),
        ModuleRoute(Routes.addressModule, module: AddressModule()),
      ];

  @override
  void listen() {
    on<AuthLoggedInEvent>((event, context) {
      if (context != null) Go.of(context).goNeglect(Routes.myAddresses);
    });
  }

  @override
  void initState(Injector i) {
    // TODO: implement initState
    super.initState(i);
  }
}
