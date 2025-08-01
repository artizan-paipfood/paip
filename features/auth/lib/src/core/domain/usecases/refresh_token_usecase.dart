import 'package:auth/src/core/domain/models/refresh_token_model.dart';
import 'package:auth/src/core/data/memory/auth_memory.dart';
import 'package:auth/src/core/domain/usecases/force_refresh_token_usecase.dart';
import 'package:auth/src/core/domain/usecases/get_refresh_token_cached_usecase.dart';
import 'package:auth/src/core/domain/usecases/save_refresh_token_cached_usecase.dart';
import 'package:auth/src/core/domain/events/events.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';

class RefreshTokenUsecase {
  final IAuthApi authApi;
  final AuthMemory authMemory;
  final GetRefreshTokenCachedUsecase getRefreshTokenCachedUsecase;
  final ForceRefreshTokenUsecase forceRefreshTokenUsecase;
  final SaveRefreshTokenCachedUsecase saveRefreshTokenCachedUsecase;
  final String encryptKey;

  RefreshTokenUsecase({
    required this.authApi,
    required this.authMemory,
    required this.getRefreshTokenCachedUsecase,
    required this.forceRefreshTokenUsecase,
    required this.saveRefreshTokenCachedUsecase,
    required this.encryptKey,
  });

  Future<AuthenticatedUser> call() async {
    try {
      //*
      final model = await _getCachedRefreshToken();
      final authenticatedUser = await _attemptTokenRefresh(model);

      _validateDeviceAuthId(authenticatedUser: authenticatedUser, model: model);
      _updateAuthenticationState(authenticatedUser);

      await _saveRefreshTokenToCache(authenticatedUser, model);

      return authenticatedUser;
      //*
    } catch (e) {
      if (e is RefreshTokenNotFoundException || e is DispositiveAuthIdExpiredException || e is RefreshTokenExpiredException) {
        _emitRefreshTokenFailureEvent();
        rethrow;
      }
      return await _handleRefreshTokenFallback();
    }
  }

  Future<RefreshTokenModel> _getCachedRefreshToken() async => await getRefreshTokenCachedUsecase();

  Future<AuthenticatedUser> _attemptTokenRefresh(RefreshTokenModel model) async {
    return await authApi.refreshToken(refreshToken: model.refreshToken);
  }

  void _validateDeviceAuthId({required AuthenticatedUser authenticatedUser, required RefreshTokenModel model}) {
    if (authenticatedUser.user.userMetadata.dispositiveAuthId != model.dispositiveAuthId) {
      throw DispositiveAuthIdExpiredException();
    }
  }

  void _updateAuthenticationState(AuthenticatedUser authenticatedUser) {
    authMemory.refreshToken(authenticatedUser);
    ModularEvent.fire(RefreshTokenEvent(authenticatedUser: authenticatedUser));
  }

  void _emitRefreshTokenFailureEvent() {
    ModularEvent.fire(RefreshTokenEvent(authenticatedUser: null));
  }

  // Método extraído para evitar duplicação
  Future<void> _saveRefreshTokenToCache(AuthenticatedUser authenticatedUser, RefreshTokenModel model) async {
    await saveRefreshTokenCachedUsecase(
      authenticatedUser: authenticatedUser,
      dispositiveAuthId: model.dispositiveAuthId,
      expiresAt: model.expiresAt,
    );
  }

  Future<AuthenticatedUser> _handleRefreshTokenFallback() async {
    try {
      final model = await _getCachedRefreshToken();
      return await _forceRefreshToken(model);
    } catch (e) {
      _emitRefreshTokenFailureEvent();
      rethrow;
    }
  }

  // Método privado agora
  Future<AuthenticatedUser> _forceRefreshToken(RefreshTokenModel model) async {
    try {
      final authenticatedUser = await forceRefreshTokenUsecase(model: model, encryptKey: encryptKey);

      _updateAuthenticationState(authenticatedUser);
      await _saveRefreshTokenToCache(authenticatedUser, model);

      return authenticatedUser;
    } catch (e) {
      _emitRefreshTokenFailureEvent();
      rethrow;
    }
  }
}
