import 'package:auth/src/domain/models/refresh_token_model.dart';
import 'package:core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetRefreshTokenCachedUsecase {
  Future<RefreshTokenModel> call({required String jwtSecret}) async {
    final preferences = await SharedPreferences.getInstance();
    try {
      final token = preferences.getString(RefreshTokenModel.prefsKey);
      if (token == null) throw RefreshTokenNotFoundException();
      return RefreshTokenModel.fromToken(token: token, jwtSecret: jwtSecret);
    } catch (e) {
      await preferences.remove(RefreshTokenModel.prefsKey);
      throw RefreshTokenExpiredException();
    }
  }
}
