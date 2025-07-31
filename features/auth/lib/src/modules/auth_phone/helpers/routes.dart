import 'package:ui/ui.dart';

class AuthPhoneRoute {
  final String module;
  AuthPhoneRoute(this.module);

  String userNameRelative = '/user-name';
  String userNameNamedRoute = 'userName';
  String userName() => '$module/user-name'.normalizePath();

  String phoneRelative = '/phone';
  String phoneNamedRoute = 'phone';
  String phone() => '$module/phone'.normalizePath();

  String phoneConfirmRelative = '/phone-confirm';
  String phoneConfirmNamedRoute = 'phoneConfirm';
  String phoneConfirm() => '$module/phone-confirm'.normalizePath();
}
