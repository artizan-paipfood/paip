import 'package:paipfood_package/paipfood_package.dart';

abstract class IAuthRepository {
  Future<AuthModel> signUpByEmail({required String email, required String password});
  Future<AuthModel> loginByEmail({required String email, required String password});
  Future<AuthModel> signUpByPhone({required String phone, required String countryCode});
  Future<AuthModel> loginByPhone({required String phone, required String countryCode});
  Future<AuthModel> refreshToken({required String refreshToken});
  Future<void> logout({required AuthModel auth});
  Future<bool> userExistsByPhone({required String value});
  Future<bool> userExistsByEmail({required String value});
  Future<AuthModel> updateUser({required AuthModel auth});
  Future<void> updateEmail({required AuthModel auth, required String newEmail});
  Future<void> forgotPassword({required String email});
  Future<void> updatePassword({required String token, required String newPassword});
  Future<UserModel> getUser({required AuthModel auth});
}
