import 'package:core/core.dart';

extension DBLocaleExtensionI18n on AppLocaleCode {
  String get language {
    return switch (this) {
      AppLocaleCode.br => 'pt_BR',
      AppLocaleCode.gb => 'en',
    };
  }
}
