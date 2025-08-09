import 'package:core/core.dart';
import 'package:ui/ui.dart';

extension FormExtensionByLocale on AppLocaleCode {
  FormController cepValidator({required bool isRequired}) {
    return switch (this) {
      AppLocaleCode.br => CepValidator(isRequired: isRequired),
      AppLocaleCode.gb => PostCodeValidator(isRequired: isRequired),
    };
  }
}
