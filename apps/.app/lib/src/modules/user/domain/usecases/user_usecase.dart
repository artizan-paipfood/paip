import 'package:app/src/modules/user/domain/dtos/user_dto.dart';
import 'package:paipfood_package/paipfood_package.dart';

class UserUsecase {
  final IAuthRepository authRepo;
  final PhoneRefreshTokenService refreshTokenMicroService;

  UserUsecase({required this.authRepo, required this.refreshTokenMicroService});

  Future<AuthModel> update(UserDto userDto) async {
    AuthNotifier.instance.update(AuthNotifier.instance.auth.copyWith(user: AuthNotifier.instance.auth.user!.copyWith(name: userDto.name, phone: userDto.phone, phoneCountryCode: userDto.phoneCountryCode, wppPhoneFormated: userDto.wppPhoneFormated)));

    return await authRepo.updateUser(auth: AuthNotifier.instance.auth);
  }

  Future<AuthModel> refreshToken() async {
    return await refreshTokenMicroService.refreshToken();
  }
}
