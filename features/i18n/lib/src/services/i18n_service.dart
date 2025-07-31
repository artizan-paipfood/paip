import 'package:flutter/material.dart';
import 'package:i18n/i18n/gen/strings.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class I18nService {
  static I18nService? _instance;

  I18nService._() {
    LocaleSettings.getLocaleStream().listen((event) {
      _locale.value = event.flutterLocale;
    });
  }
  static I18nService get instance => _instance ??= I18nService._();

  SharedPreferences? _prefs;

  bool userHasSetLanguage = false;

  final ValueNotifier<Locale> _locale = ValueNotifier(LocaleSettings.currentLocale.flutterLocale);

  ValueNotifier<Locale> get observer => _locale;

  Locale get locale => _locale.value;

  Future<void> setLanguage(String language) async {
    await _prefs?.setString('language', language);
    LocaleSettings.setLocaleRaw(language);
  }

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    String? language = _prefs?.getString('language');
    if (language == null) {
      language = 'en_US';
      userHasSetLanguage = false;
    } else {
      userHasSetLanguage = true;
    }
    LocaleSettings.setLocaleRaw(language);
  }

  Future<void> clearLanguage() async {
    await _prefs?.remove('language');
    userHasSetLanguage = false;
  }
}
