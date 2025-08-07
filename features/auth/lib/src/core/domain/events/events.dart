import 'package:core/core.dart';

class LoginUserEvent {
  final AuthenticatedUser authenticatedUser;
  LoginUserEvent({required this.authenticatedUser});
}

class LogoutUserEvent {
  LogoutUserEvent();
}
