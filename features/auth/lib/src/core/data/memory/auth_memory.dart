import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

class AuthMemory {
  static AuthMemory? _instance;
  AuthMemory._();
  static AuthMemory get instance => _instance ??= AuthMemory._();

  final ValueNotifier<AuthenticatedUser?> _authenticatedUser = ValueNotifier(null);

  ValueNotifier<AuthenticatedUser?> get observer => _authenticatedUser;

  UserEntity? get user => _authenticatedUser.value?.user;

  bool get isLoggedIn => _authenticatedUser.value != null;
  bool get isNotLoggedIn => !isLoggedIn;

  void login(AuthenticatedUser authenticatedUser) {
    _authenticatedUser.value = authenticatedUser;
  }

  void logout() {
    _authenticatedUser.value = null;
  }

  void refreshToken(AuthenticatedUser authenticatedUser) => login(authenticatedUser);

  void setUser(UserEntity user) {
    if (isNotLoggedIn) throw Exception('User not logged in');
    _authenticatedUser.value = _authenticatedUser.value?.copyWith(user: user);
  }
}
