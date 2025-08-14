import 'dart:developer';

import 'package:core_flutter/src/dependencies.dart';
import 'package:flutter/cupertino.dart';

class AppLocale {
  AppLocale._();

  static final ValueNotifier<AppLocaleCode> _appLocale = ValueNotifier(AppLocaleCode.gb);

  static ValueNotifier<AppLocaleCode> get observer => _appLocale;

  static AppLocaleCode get locale => _appLocale.value;

  static String get currencySymbol => locale.currencySymbol;

  static void setAppLocale(AppLocaleCode appLocale) {
    log('Change locale to ${appLocale.countryCode.toString()}', name: 'APP-LOG');
    _appLocale.value = appLocale;
  }

  static void setAppLocaleRaw(String countryCode) {
    log('Change locale to $countryCode', name: 'APP-LOG');
    _appLocale.value = AppLocaleCode.fromCountryCode(countryCode);
  }
}

extension AppLocaleString on double {
  String toCurrency() => '${AppLocale.currencySymbol} ${toStringAsFixed(2)}';
}
