import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paipfood_package/paipfood_package.dart';

Map mapI18n = {};

class LanguageNotifier {
  static LanguageNotifier? _instance;

  LanguageNotifier._();
  static LanguageNotifier get instance => _instance ??= LanguageNotifier._();

  SharedPreferences get _cache => LocalStorageSharedPreferences.instance.sharedPreferences;

  ValueNotifier<Locale> localeNotifier = ValueNotifier(Locale('en'));
  Locale get locale => localeNotifier.value;

  static const String _box = 'locale';

  Future<void> initialize() async {
    final data = _cache.getString(_box);
    if (data != null) {
      final Locale result = _localeFromString(data);
      _setIntl(result);
      localeNotifier.value = result;
      await _setI18nMap(result);
    }
  }

  void _setIntl(Locale locale) async {
    if (Intl.defaultLocale == locale.toString()) return;
    Intl.defaultLocale = locale.toString();
  }

  void change(Locale locale) {
    _setIntl(locale);
    localeNotifier.value = locale;
    _cache.setString(_box, locale.toString());
    _setI18nMap(locale);
  }

  Future<void> _setI18nMap(Locale locale) async {
    log(locale.toString(), name: 'CHANGE LOCALE:');
    final String path = "lib/l10n/app_${_localeToString(locale)}.arb";
    final fileText = await rootBundle.loadString(path);
    mapI18n = jsonDecode(fileText);
  }

  Locale _localeFromString(String value) {
    final split = value.split('_');
    return Locale(split[0], split.length > 1 ? split[1] : '');
  }

  String _localeToString(Locale locale) {
    final list = [
      locale.languageCode
    ];
    if (locale.countryCode != null && locale.countryCode!.isNotEmpty) list.add(locale.countryCode!);
    final result = list.join('_');
    return result;
  }
}
