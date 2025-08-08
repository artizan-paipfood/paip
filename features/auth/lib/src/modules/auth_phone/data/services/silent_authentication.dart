import 'package:auth/auth.dart';
import 'package:auth/src/core/data/services/singletons/device_id.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';

class SilentAuthentication {
  final Duration expiresIn;
  final IAuthApi authApi;
  final ICacheService cache;
  final String encryptKey;
  SilentAuthentication({required this.expiresIn, required this.authApi, required this.cache, required this.encryptKey});

  AuthenticatedUser? _authenticatedUser;

  Future<UserMeModel?> auth() async {
    try {
      if (UserMe.me != null) return UserMe.me;
      final credentials = await AuthTokensCache.getCredentials();
      if (credentials == null) return null;
      _authenticatedUser = await _login(credentials: credentials);
      await AuthTokensCache.saveTokens(AuthTokens(accessToken: _authenticatedUser!.accessToken, refreshToken: _authenticatedUser!.refreshToken, expiresAt: DateTime.now().add(expiresIn)));
      await _validateDispositiveAuthIdOnAuth(_authenticatedUser!);
      await UserMe.refresh(userId: _authenticatedUser!.user.id);
      return UserMe.me;
    } catch (e) {
      await _onError();
      return null;
    }
  }

  Future<void> logout() async {
    _authenticatedUser = null;
    final tokens = await AuthTokensCache.getTokens();
    await UserMe.logout();
    if (tokens != null) await authApi.logout(accessToken: tokens.accessToken);
  }

  Future<void> _onError() async {
    _authenticatedUser = null;
    await AuthTokensCache.clear();
  }

  Future<void> _validateDispositiveAuthIdOnAuth(AuthenticatedUser auth) async {
    final dispositiveAuthId = await DeviceId.get();
    final currentDispositiveAuthId = auth.user.userMetadata.dispositiveAuthId;
    if (currentDispositiveAuthId == dispositiveAuthId) return;
    ModularEvent.fire(DispositiveAuthIdExpiredException());
    throw Exception('Dispositive auth id is not valid');
  }

  Future<AuthenticatedUser> loginByPhone({required PhoneNumber phoneNumber, String? fullname}) async {
    final auth = await _loginOrRegisterByPhone(phoneNumber: phoneNumber);
    await _saveCache(credentials: Credentials(phone: phoneNumber), auth: auth);
    await _updateUserMetadata(auth: auth, fullName: fullname);
    _authenticatedUser = auth;
    return auth;
  }

  Future<AuthenticatedUser> _loginOrRegisterByPhone({required PhoneNumber phoneNumber}) async {
    final userExists = await authApi.userExistsByPhone(phoneNumber: phoneNumber);
    if (userExists) return await authApi.loginByPhone(encryptKey: encryptKey, phoneNumber: phoneNumber);
    return await authApi.signUpByPhone(encryptKey: encryptKey, phoneNumber: phoneNumber);
  }

  Future<AuthenticatedUser> loginByEmail({required String email, required String password}) async {
    final auth = await authApi.loginByEmail(email: email, password: password);
    await _saveCache(credentials: Credentials(email: email, password: password), auth: auth);
    await _updateUserMetadata(auth: auth);
    _authenticatedUser = auth;
    return auth;
  }

  Future<void> _updateUserMetadata({required AuthenticatedUser auth, String? fullName}) async {
    final dispositiveAuthId = await DeviceId.get();
    if (auth.user.userMetadata.dispositiveAuthId == dispositiveAuthId && fullName == null) return;
    fullName ??= auth.user.userMetadata.fullName;
    await authApi.updateMe(
      me: UserMeModel(
        id: auth.user.id,
        metadata: auth.user.userMetadata.copyWith(dispositiveAuthId: dispositiveAuthId, fullName: fullName),
        addresses: [],
      ),
    );
  }

  Future<void> _saveCache({required Credentials credentials, required AuthenticatedUser auth}) async {
    final tokens = AuthTokens(accessToken: auth.accessToken, refreshToken: auth.refreshToken, expiresAt: DateTime.now().add(expiresIn));
    await AuthTokensCache.saveTokens(tokens);
    DateTime expiresAt = DateTime.now().add(expiresIn);
    final data = await AuthTokensCache.getCredentials();
    if (data != null) {
      expiresAt = data.expiresAt ?? expiresAt;
    }
    await AuthTokensCache.saveCredentials(credentials.copyWith(expiresAt: expiresAt));
  }

  Future<AuthenticatedUser?> _login({required Credentials credentials}) async {
    final provider = credentials.provider();
    if (provider == null) return null;

    if (provider == AuthenticatorProvider.phone) {
      final auth = await authApi.loginByPhone(encryptKey: encryptKey, phoneNumber: credentials.phone!);
      return auth;
    }
    if (provider == AuthenticatorProvider.email) {
      final auth = await authApi.loginByEmail(email: credentials.email!, password: credentials.password!);
      return auth;
    }
    return null;
  }
}
