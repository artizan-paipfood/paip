import 'package:auth/src/domain/usecases/save_refresh_token_cached_usecase.dart';
import 'package:auth/src/memory/auth_memory.dart';
import 'package:auth/src/modules/auth_phone/presentation/viewmodels/auth_phone_viewmodel.dart';
import 'package:core/core.dart';

class AuthPhoneService {
  final SaveRefreshTokenCachedUsecase saveRefreshTokenCachedUsecase;

  final IAuthApi authApi;
  final AuthMemory authMemory;
  final String jwtSecret;
  final String encryptKey;

  AuthPhoneService({
    required this.saveRefreshTokenCachedUsecase,
    required this.authApi,
    required this.authMemory,
    required this.jwtSecret,
    required this.encryptKey,
  });

  Future<AuthenticatedUser> completeAuthenticationFlow({
    required AuthenticatedUser authenticatedUser,
    String? fullName,
  }) async {
    final dispositiveAuthId = Uuid().v4();

    await saveRefreshTokenCachedUsecase(
      authenticatedUser: authenticatedUser,
      dispositiveAuthId: dispositiveAuthId,
      jwtSecret: jwtSecret,
      expiresIn: AuthPhoneControllerConstants.refreshTokenDuration,
    );

    final updatedUser = _buildUpdatedUser(authenticatedUser: authenticatedUser, dispositiveAuthId: dispositiveAuthId, fullName: fullName);
    final finalAuthenticatedUser = authenticatedUser.copyWith(user: updatedUser);

    await authApi.updateUser(user: updatedUser, accessToken: authenticatedUser.accessToken);

    authMemory.login(finalAuthenticatedUser);

    return finalAuthenticatedUser;
  }

  Future<UserEntity> updateNumberAndPassword({required PhoneNumber phoneNumber, required AuthenticatedUser authenticatedUser}) async {
    phoneNumber.validate();

    await authApi.updatePasswordPhone(
      phoneNumber: phoneNumber,
      encryptKey: encryptKey,
      accessToken: authenticatedUser.accessToken,
    );

    final updatedUser = _buildUserWithNewPhone(authenticatedUser: authenticatedUser, phoneNumber: phoneNumber);

    await authApi.updateUser(user: updatedUser, accessToken: authenticatedUser.accessToken);

    final updatedAuthenticatedUser = authenticatedUser.copyWith(user: updatedUser);
    authMemory.login(updatedAuthenticatedUser);

    return updatedUser;
  }

  UserEntity _buildUpdatedUser({required AuthenticatedUser authenticatedUser, required String dispositiveAuthId, required String? fullName}) {
    var userMetadata = authenticatedUser.user.userMetadata.copyWith(
      dispositiveAuthId: dispositiveAuthId,
    );

    if (fullName != null) {
      userMetadata = userMetadata.copyWith(fullName: fullName);
    }

    return authenticatedUser.user.copyWith(userMetadata: userMetadata);
  }

  UserEntity _buildUserWithNewPhone({required AuthenticatedUser authenticatedUser, required PhoneNumber phoneNumber}) {
    return authenticatedUser.user.copyWith(
      phone: phoneNumber.fullPhoneOnlyNumbers(),
      userMetadata: authenticatedUser.user.userMetadata.copyWith(phoneNumber: phoneNumber),
    );
  }
}
