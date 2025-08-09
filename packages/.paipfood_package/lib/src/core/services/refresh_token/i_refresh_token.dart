import 'package:paipfood_package/paipfood_package.dart';

abstract interface class IRefreshToken {
  Future<AuthModel> refreshToken();
  Future<AuthModel> login(AuthModel auth);
  Future<void> logout();
}
