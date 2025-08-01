import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/auth/presenters/pages/login_page.dart';
import 'package:app/src/modules/auth/presenters/pages/splash_page.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AuthModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(Routes.splashRelvative, child: (context, state) => const SplashPage()),
        ChildRoute(Routes.loginRelative, child: (context, state) => const LoginPage()),
      ];
}
