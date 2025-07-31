import 'dart:async';
import 'package:portal/src/core/helpers/routes.dart';
import 'package:portal/src/modules/auth/auth_module.dart';
import 'package:portal/src/modules/changelog/changelog_module.dart';
import 'package:portal/src/modules/home/home_module.dart';
import 'package:portal/src/modules/jwt/secret_page.dart';
import 'package:portal/src/modules/policy/policy_module.dart';
import 'package:portal/src/modules/register/register_module.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AppModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.singleton((i) => ClientDio(baseOptions: HttpUtils.supabaseBaseoptions)),
        Bind.singleton((i) => AuthRepository(http: i.get())),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Routes.homeModule, module: HomeModule()),
        ModuleRoute(Routes.registerModule, module: RegisterModule()),
        ModuleRoute(Routes.authModule, module: AuthModule()),
        ModuleRoute(Routes.policyModule, module: PolicyModule()),
        ModuleRoute(Routes.changelogModule, module: ChangelogModule()),
        ChildRoute(
          SecretPage.route,
          child: (context, args) => const SecretPage(),
        )
      ];
}
