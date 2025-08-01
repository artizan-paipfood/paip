import 'package:auth/src/core/domain/models/refresh_token_model.dart';
import 'package:core/core.dart';

class ForceRefreshTokenUsecase {
  final IAuthApi authApi;
  ForceRefreshTokenUsecase({required this.authApi});
  Future<AuthenticatedUser> call({required RefreshTokenModel model, required String encryptKey}) async {
    if (model.provider() == AuthenticatorProvider.phone) {
      final auth = await authApi.loginByPhone(encryptKey: encryptKey, phoneNumber: model.phone!);
      return auth;
    }
    if (model.provider() == AuthenticatorProvider.email) {
      final auth = await authApi.loginByEmail(email: model.email!, password: model.password!);
      return auth;
    }
    throw Exception('Invalid provider');
  }
}
