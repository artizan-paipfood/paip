import 'package:paipfood_package/paipfood_package.dart';

class ChangePasswordUsecase {
  final AuthRepository authRepo;
  ChangePasswordUsecase({required this.authRepo});
  Future<void> call({required String token, required String newPassword}) async {
    await authRepo.updatePassword(token: token, newPassword: newPassword);
  }
}
