import 'dart:ui';
import 'package:core/core.dart';

extension DbLocaleExtension on AppLocaleCode {
  String get dialCode {
    return switch (this) {
      AppLocaleCode.br => '55',
      AppLocaleCode.gb => '44',
    };
  }

  Locale get locale {
    return switch (this) {
      AppLocaleCode.br => Locale('pt', 'BR'),
      AppLocaleCode.gb => Locale('en'),
    };
  }
}
