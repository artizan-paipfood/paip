import 'dart:ui';
import 'package:core/core.dart';

extension DbLocaleExtension on DbLocale {
  String get dialCode {
    return switch (this) {
      DbLocale.br => '55',
      DbLocale.gb => '44',
    };
  }

  Locale get locale {
    return switch (this) {
      DbLocale.br => Locale('pt', 'BR'),
      DbLocale.gb => Locale('en'),
    };
  }
}
