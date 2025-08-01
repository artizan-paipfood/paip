import 'package:auth/src/core/domain/models/refresh_token_model.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';

class SaveRefreshTokenCachedUsecase {
  final CacheServiceEncrypted cache;

  SaveRefreshTokenCachedUsecase({required this.cache});

  Future<void> call({required AuthenticatedUser authenticatedUser, required String dispositiveAuthId, required DateTime expiresAt, String? password}) async {
    final data = await cache.get(box: RefreshTokenModel.prefsKey);

    if (data != null) {
      final token = RefreshTokenModel.fromMap(data);
      expiresAt = token.expiresAt;
    }
    final token = RefreshTokenModel.fromAuthenticatedUser(authenticatedUser: authenticatedUser, dispositiveAuthId: dispositiveAuthId, password: password, expiresAt: expiresAt);
    await cache.save(box: RefreshTokenModel.prefsKey, data: token.toMap(), expiresAt: expiresAt);
  }
}
