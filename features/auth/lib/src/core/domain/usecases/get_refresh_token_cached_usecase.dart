import 'package:auth/src/core/domain/models/refresh_token_model.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';

class GetRefreshTokenCachedUsecase {
  final CacheServiceEncrypted cache;

  GetRefreshTokenCachedUsecase({required this.cache});

  Future<RefreshTokenModel> call() async {
    try {
      final token = await cache.get(box: RefreshTokenModel.prefsKey);
      if (token == null) throw RefreshTokenNotFoundException();
      return RefreshTokenModel.fromMap(token);
    } catch (e) {
      await cache.delete(box: RefreshTokenModel.prefsKey);
      throw RefreshTokenExpiredException();
    }
  }
}
