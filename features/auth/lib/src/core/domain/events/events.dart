import 'package:core/core.dart';

class RefreshTokenEvent {
  final AuthenticatedUser? authenticatedUser;
  RefreshTokenEvent({required this.authenticatedUser});
}

class AuthLoggedInEvent {
  final AuthenticatedUser authenticatedUser;
  AuthLoggedInEvent({required this.authenticatedUser});
}

class UserLoggedOutEvent {
  UserLoggedOutEvent();
}

class UserUpdatedEvent {
  final AuthenticatedUser authenticatedUser;
  UserUpdatedEvent({required this.authenticatedUser});
}
