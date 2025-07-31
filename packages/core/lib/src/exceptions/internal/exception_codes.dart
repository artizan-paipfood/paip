import 'package:core/src/exceptions/internal/base.dart';

class InternalExceptionHelper {
  InternalExceptionHelper._();

  static Map<int, InternalException> errors = {
    1401: AddressOutOfDeliveryRadiusException(),
    1801: RefreshTokenExpiredException(),
    1802: DispositiveAuthIdExpiredException(),
  };

  // ignore: unused_field
  final Map<int, String> _prefixErrors = {
    14: "Address Error",
    15: "Payment Error",
    16: "Order Error",
    17: "User Error",
    18: "Auth Error",
  };
  static String getMessage({required int code, required String language}) {
    final error = errors[code];
    if (error == null) {
      return 'Unknown error';
    }
    final message = error.messages[language];
    if (message == null) return error.messages['en_US'] as String;
    return message;
  }
}

//* ADDRESS *****************************************************
class AddressOutOfDeliveryRadiusException extends InternalException {
  AddressOutOfDeliveryRadiusException()
      : super(
          code: 1401,
          description: 'Endereço fora do raio de entrega',
          messages: {
            'pt': 'Endereço fora do raio de entrega',
            'pt_BR': 'Endereço fora do raio de entrega',
            'en_US': 'Address out of delivery radius',
          },
        );
}

//* AUTH *****************************************************
class RefreshTokenExpiredException extends InternalException {
  RefreshTokenExpiredException()
      : super(
          code: 1801,
          description: 'Refresh token expired',
          messages: {
            'pt': 'Refresh token expirado',
            'pt_BR': 'Refresh token expirado',
            'en_US': 'Refresh token expired',
          },
        );
}

class DispositiveAuthIdExpiredException extends InternalException {
  DispositiveAuthIdExpiredException()
      : super(
          code: 1802,
          description: 'Dispositive auth id expired',
          messages: {
            'pt': 'Dispositive auth id expirado',
            'pt_BR': 'Dispositive auth id expirado',
            'en_US': 'Dispositive auth id expired',
          },
        );
}

class RefreshTokenNotFoundException extends InternalException {
  RefreshTokenNotFoundException()
      : super(
          code: 1803,
          description: 'Refresh token not found',
          messages: {
            'pt': 'Refresh token não encontrado',
            'pt_BR': 'Refresh token não encontrado',
            'en_US': 'Refresh token not found',
          },
        );
}
