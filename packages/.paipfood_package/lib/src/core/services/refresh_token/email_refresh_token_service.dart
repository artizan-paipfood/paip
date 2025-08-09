import 'package:core_flutter/core_flutter.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:paipfood_package/src/core/services/refresh_token/refresh_token_dto.dart';

class EmailRefreshTokenService implements IRefreshToken {
  final IAuthRepository authRepository;

  EmailRefreshTokenService({
    required this.authRepository,
  });

  final SharedPreferences _cache = LocalStorageSharedPreferences.instance.sharedPreferences;

  static const _key = "paip_email_refresh_token";

  @override
  Future<AuthModel> refreshToken() async {
    try {
      final RefreshTokenDto authDto = await _loadAuthDtoFromToken();
      AuthModel? authModel;

      try {
        authModel = await authRepository.refreshToken(refreshToken: authDto.refreshToken);
      } catch (e) {
        authModel = await authRepository.loginByEmail(
          email: authDto.email,
          password: authDto.password,
        );
      }

      await _saveEmailRefreshToken(authModel: authModel, dispositiveAuthId: authModel.user!.dispositiveAuthId);

      return authModel;
    } catch (e) {
      await logout();
      throw Exception("Token expired");
    }
  }

  Future<RefreshTokenDto> _loadAuthDtoFromToken() async {
    final data = _cache.getString(_key);
    if (data == null) throw Exception("Token not found");
    final decode = JwtService.decodeToken(token: data, secret: Env.secretKey);
    return RefreshTokenDto.fromMap(decode);
  }

  @override
  Future<AuthModel> login(AuthModel authModel) async {
    final dispositiveAuthId = uuid;
    await _saveEmailRefreshToken(authModel: authModel, dispositiveAuthId: dispositiveAuthId);
    return await authRepository.updateUser(auth: authModel.copyWith(user: authModel.user!.copyWith(dispositiveAuthId: dispositiveAuthId)));
  }

  Future<void> _saveEmailRefreshToken({required AuthModel authModel, required String dispositiveAuthId}) async {
    if (dispositiveAuthId.isEmpty) throw Exception("DISPOSITIVE-AUTH-ID not found");
    final authDto = RefreshTokenDto.fromAuth(
      auth: authModel,
      dispositiveAuthId: dispositiveAuthId,
    );
    final token = JwtService.buildToken(map: authDto.toMap(), expiresIn: 360.days, secret: Env.secretKey);
    await _cache.setString(_key, token);
  }

  @override
  Future<void> logout() async {
    await _cache.remove(_key);
    await authRepository.logout(auth: AuthNotifier.instance.auth);
  }
}
