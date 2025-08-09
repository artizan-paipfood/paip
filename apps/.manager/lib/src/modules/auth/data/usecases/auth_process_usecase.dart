import 'package:flutter/cupertino.dart';
import 'package:manager/src/core/helpers/routes.dart';
import 'package:manager/src/modules/auth/data/services/auth_service.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AuthProcessUsecase {
  final BuildContext context;
  final AuthService authService;

  AuthProcessUsecase({required this.context, required this.authService});
  Future<void> call() async {
    final isLogged = await authService.checkLoggedIn();
    if (context.mounted) {
      switch (isLogged) {
        case true:
          context.go(Routes.orders);
        case false:
          context.go(Routes.login);
      }
    }
  }
}
