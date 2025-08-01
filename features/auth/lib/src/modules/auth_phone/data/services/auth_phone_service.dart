import 'package:auth/src/core/data/services/device_id_service.dart';
import 'package:auth/src/core/domain/usecases/save_refresh_token_cached_usecase.dart';
import 'package:auth/src/core/data/memory/auth_memory.dart';
import 'package:auth/src/modules/auth_phone/presentation/viewmodels/auth_phone_viewmodel.dart';
import 'package:core/core.dart';

class AuthPhoneService {
  final SaveRefreshTokenCachedUsecase saveRefreshTokenCachedUsecase;
  final DeviceIdService deviceIdService;

  final IAuthApi authApi;
  final AuthMemory authMemory;
  final String encryptKey;

  AuthPhoneService({
    required this.saveRefreshTokenCachedUsecase,
    required this.authApi,
    required this.authMemory,
    required this.encryptKey,
    required this.deviceIdService,
  });

  Future<AuthenticatedUser> completeAuthenticationFlow({
    required AuthenticatedUser authenticatedUser,
    String? fullName,
  }) async {
    final dispositiveAuthId = await deviceIdService.get();

    await saveRefreshTokenCachedUsecase(
      authenticatedUser: authenticatedUser,
      dispositiveAuthId: dispositiveAuthId,
      expiresAt: DateTime.now().add(AuthPhoneControllerConstants.refreshTokenDuration),
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
