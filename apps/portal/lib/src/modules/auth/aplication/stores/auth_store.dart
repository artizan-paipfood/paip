import 'package:portal/src/modules/auth/aplication/usecases/change_password_usecase.dart';

class AuthStore {
  final ChangePasswordUsecase changePasswordUsecase;

  AuthStore({required this.changePasswordUsecase});

  Future<void> resetPassword({required String token, required String newPassword}) async {
    await changePasswordUsecase.call(token: token, newPassword: newPassword);
  }
}
