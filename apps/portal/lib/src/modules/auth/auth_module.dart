import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/src/core/helpers/routes.dart';
import 'package:portal/src/modules/auth/presenters/pages/confirm_email_page.dart';
import 'package:portal/src/modules/auth/presenters/pages/reset_password_page.dart';

class AuthModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(Routes.confirmEmailRelative, child: (context, state) => const ConfirmEmailPage()),
        ChildRoute(Routes.resetPasswordRelative, child: (context, state) => const ResetPasswordPage()),
      ];
}
