import 'package:auth/src/core/data/services/singletons/user_me.dart';
import 'package:core/core.dart';

class UpdateUserPhoneUsecase {
  final IAuthApi authApi;
  final String encryptKey;

  UpdateUserPhoneUsecase({
    required this.authApi,
    required this.encryptKey,
  });

  Future<void> call({required PhoneNumber phoneNumber, required AuthenticatedUser authenticatedUser}) async {
    phoneNumber.validate();

    await authApi.updatePasswordPhone(
      phoneNumber: phoneNumber,
      encryptKey: encryptKey,
      accessToken: authenticatedUser.accessToken,
    );

    final updatedUser = _buildUserWithNewPhone(authenticatedUser: authenticatedUser, phoneNumber: phoneNumber);

    await authApi.updateMe(
      me: UserMe.me!.copyWith(metadata: UserMe.me!.metadata.copyWith(phoneNumber: phoneNumber)),
    );

    await UserMe.refresh(userId: updatedUser.id);
  }

  UserEntity _buildUserWithNewPhone({required AuthenticatedUser authenticatedUser, required PhoneNumber phoneNumber}) {
    return authenticatedUser.user.copyWith(
      phone: phoneNumber.fullPhoneOnlyNumbers(),
      userMetadata: authenticatedUser.user.userMetadata.copyWith(phoneNumber: phoneNumber),
    );
  }
}
