import 'package:core/i18n/gen/strings.g.dart';

class SlangDartCore {
  SlangDartCore._();
  static final Map<String, Translations> _translations = {};

  static Translations translation(String locale) {
    return _translations[locale]!;
  }

  static Future<void> initalize() async {
    _translations[AppLocale.ptBr.underscoreTag] = await AppLocale.ptBr.build();
    _translations[AppLocale.enUs.underscoreTag] = await AppLocale.enUs.build();
  }
}
