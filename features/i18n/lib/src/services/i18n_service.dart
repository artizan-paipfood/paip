import 'package:flutter/material.dart';
import 'package:i18n/i18n/gen/strings.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppI18n {
  AppI18n._();

  static SharedPreferences? _prefs;

  static bool userHasSetLanguage = false;

  static final ValueNotifier<Locale> _locale = ValueNotifier(LocaleSettings.currentLocale.flutterLocale);

  static ValueNotifier<Locale> get observer => _locale;

  static Locale get locale => _locale.value;

  static bool _isInitialized = false;

  static void _listenSlang() {
    LocaleSettings.getLocaleStream().listen((event) {
      _prefs?.setString('language', event.underscoreTag);
    });
  }

  static Future<String> initialize() async {
    if (_isInitialized) return _locale.value.languageCode;
    _isInitialized = true;

    _prefs = await SharedPreferences.getInstance();
    String? language = _prefs?.getString('language');
    _listenSlang();
    if (language == null) {
      language = 'en_US';
      userHasSetLanguage = false;
    } else {
      userHasSetLanguage = true;
    }
    return language;
  }

  static Future<void> clearLanguage() async {
    await _prefs?.remove('language');
    userHasSetLanguage = false;
  }
}
