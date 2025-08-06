import 'package:core/core.dart';

class TokenExpiredException extends AppError {
  TokenExpiredException() : super(code: ErrorCode.TOKEN_EXPIRADO.code);
}

class TokenInvalidException extends AppError {
  TokenInvalidException() : super(code: ErrorCode.TOKEN_INVALIDO.code);
}

class UserNotAuthorizedException extends AppError {
  UserNotAuthorizedException() : super(code: ErrorCode.USUARIO_NAO_AUTORIZADO.code);
}

class SessionExpiredException extends AppError {
  SessionExpiredException() : super(code: ErrorCode.SESSAO_EXPIRADA.code);
}

class CredentialsInvalidException extends AppError {
  CredentialsInvalidException() : super(code: ErrorCode.CREDENCIAIS_INVALIDAS.code);
}

class RefreshTokenNotFoundException extends AppError {
  RefreshTokenNotFoundException() : super(code: ErrorCode.REFRESH_TOKEN_NOT_FOUND.code);
}

class RefreshTokenExpiredException extends AppError {
  RefreshTokenExpiredException() : super(code: ErrorCode.REFRESH_TOKEN_EXPIRED.code);
}

class DispositiveAuthIdExpiredException extends AppError {
  DispositiveAuthIdExpiredException() : super(code: ErrorCode.DISPOSITIVE_AUTH_ID_EXPIRED.code);
}

class AuthenticationError {
  static bool isTokenExpired(AppError error) {
    return error.code == ErrorCode.TOKEN_EXPIRADO.code;
  }

  static bool isTokenInvalid(AppError error) {
    return error.code == ErrorCode.TOKEN_INVALIDO.code;
  }

  static bool isUserNotAuthorized(AppError error) {
    return error.code == ErrorCode.USUARIO_NAO_AUTORIZADO.code;
  }

  static bool isSessionExpired(AppError error) {
    return error.code == ErrorCode.SESSAO_EXPIRADA.code;
  }

  static bool isCredentialsInvalid(AppError error) {
    return error.code == ErrorCode.CREDENCIAIS_INVALIDAS.code;
  }

  static bool isRefreshTokenNotFound(AppError error) {
    return error.code == ErrorCode.REFRESH_TOKEN_NOT_FOUND.code;
  }

  static bool isRefreshTokenExpired(AppError error) {
    return error.code == ErrorCode.REFRESH_TOKEN_EXPIRED.code;
  }

  static bool isDispositiveAuthIdExpired(AppError error) {
    return error.code == ErrorCode.DISPOSITIVE_AUTH_ID_EXPIRED.code;
  }
}
