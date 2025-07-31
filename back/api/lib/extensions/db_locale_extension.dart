import 'package:core/core.dart';

extension DBLocaleExtensionI18n on DbLocale {
  String get language {
    return switch (this) {
      DbLocale.br => 'pt_BR',
      DbLocale.gb => 'en',
    };
  }
}
