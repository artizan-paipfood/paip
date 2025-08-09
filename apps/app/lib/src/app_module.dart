import 'dart:async';
import 'package:address/address.dart';
import 'package:app/src/core/utils/routes.dart';
import 'package:app/src/modules/onboarding/onboarding_module.dart';
import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:explore/explore.dart';
import 'package:ui/ui.dart';

class AppModule extends EventModule {
  @override
  FutureOr<List<Module>> imports() {
    return [AuthPhoneModule()];
  }

  @override
  FutureOr<List<Bind<Object>>> binds() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final cache = CacheServiceEncrypted(sharedPreferences: sharedPreferences, encryptKey: Env.encryptKey);
    return [
      Bind.singleton((i) => cache),
      Bind.singleton((i) => ClientDio(baseOptions: PaipBaseOptions.paipApi), key: PaipBindKey.paipApi),
      Bind.singleton((i) => AuthApi(client: i.get())),
      Bind.singleton(
        (i) => ClientDio(
          baseOptions: PaipBaseOptions.supabase,
          interceptors: [SupabaseAuthInterceptor(dio: Dio())],
        ),
      ),
    ];
  }

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Routes.onboardingModule, module: OnboardingModule()),
        ModuleRoute(Routes.authModule, module: AuthPhoneModule()),
        ModuleRoute(Routes.addressModule, module: AddressModule()),
        ModuleRoute(Routes.exploreModule, module: ExploreModule()),
      ];

  @override
  void listen() {
    on<LoginUserEvent>((event, context) {
      if (context != null) Go.of(context).goNeglect(Routes.myAddresses);
    });
    on<SelectAddressEvent>((event, context) {
      if (context != null) Go.of(context).goNeglect(Routes.explore);
    });
  }
}
