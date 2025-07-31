import 'package:core/core.dart';

class InternalException {
  final int code;
  final String description;

  final Map<String, String> messages;

  InternalException({
    required this.code,
    required this.description,
    required this.messages,
  });

  Map<String, dynamic> toJson() {
    return {
      "internal_exception_code": code,
      "message": messages['en_US'],
    };
  }
}

extension InternalExceptionModelExtension on InternalException {
  bool isA<T extends InternalException>() {
    final model = InternalExceptionHelper.errors[code];
    if (model == null) return false;
    return model is T;
  }
}

extension CastException on Object {
  InternalException castAsInternalException() {
    return this as InternalException;
  }

  bool isA<T extends InternalException>(void Function(T) onError) {
    if (this is T) {
      onError(this as T);
      return true;
    }
    return false;
  }

  bool isAInternalException<T extends InternalException>() {
    if (this is InternalException) {
      final exception = this as InternalException;
      return exception.isA<T>();
    }
    return false;
  }

  void catchInternalError(void Function(InternalException e) onError) {
    if (this is InternalException) {
      onError(this as InternalException);
      return;
    }
    throw this;
  }
}

extension StringExtension on String {
  InternalException? parseInternalException() {
    final match = RegExp(r'internal_exception_code: (\d+), message: (.*)').firstMatch(this);
    if (match == null) {
      return null;
    }
    return InternalException(code: int.parse(match.group(1)!), description: match.group(2)!, messages: {'en_US': match.group(2)!});
  }
}
