import 'package:auth/src/domain/models/refresh_token_model.dart';
import 'package:core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveRefreshTokenCachedUsecase {
  Future<void> call({required AuthenticatedUser authenticatedUser, required String dispositiveAuthId, required String jwtSecret, required Duration expiresIn, String? password}) async {
    final preferences = await SharedPreferences.getInstance();
    final dtoCached = preferences.getString(RefreshTokenModel.prefsKey);
    if (dtoCached != null) {
      final dtoParsed = RefreshTokenModel.fromJson(dtoCached);
      expiresIn = dtoParsed.expiresIn;
    }
    final dto = RefreshTokenModel.fromAuthenticatedUser(authenticatedUser: authenticatedUser, dispositiveAuthId: dispositiveAuthId, password: password, expiresIn: expiresIn);
    final token = JwtService.generateToken(expiresIn: expiresIn, secretKey: jwtSecret, payload: dto.toMap());
    await preferences.setString(RefreshTokenModel.prefsKey, token);
  }
}
