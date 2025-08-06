import 'package:core_flutter/src/dependencies.dart';
import 'package:flutter/widgets.dart';

class PaipAppLocale {
  PaipAppLocale._();

  static final ValueNotifier<AppLocaleCode> _appLocale = ValueNotifier(AppLocaleCode.gb);

  static ValueNotifier<AppLocaleCode> get observer => _appLocale;

  static AppLocaleCode get locale => _appLocale.value;

  static void changeLocale(AppLocaleCode locale) async {
    _appLocale.value = locale;
  }
}
