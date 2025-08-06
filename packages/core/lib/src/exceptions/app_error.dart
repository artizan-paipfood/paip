import 'package:core/core.dart';
import 'package:core/src/exceptions/app_error_codes.dart';
import 'package:core/src/helpers/slang_dart_core.dart';

abstract class AppError extends Error {
  final int code;
  AppError({required this.code});

  String message(String localeUnderScoreTag) {
    final t = SlangDartCore.translation(localeUnderScoreTag);

    final scope = ErrorCode.scopes.firstWhere((scope) => code >= scope.min && code <= scope.max);

    final result = t['${scope.key}.k$code'];

    return result ?? 'Slang message not found code: $code';
  }

  int get statusCode {
    final errorValue = ErrorCode.values.firstWhere((e) => e.code == code);
    return errorValue.httpStatus;
  }

  Map<String, dynamic> toMap() {
    return {
      'paip_error_code': code,
      'message': message('en_US'),
      'status_code': statusCode,
    };
  }
}
