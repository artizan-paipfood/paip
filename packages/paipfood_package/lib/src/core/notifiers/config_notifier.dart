import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ConfigNotifier {
  static ConfigNotifier? _instance;
  ConfigNotifier._();
  static ConfigNotifier get instance => _instance ??= ConfigNotifier._();

  Future<void> initialize() async {
    await LocalStorageSharedPreferences.instance.initialize();
    await ThemeNotifier.instance.initialize();
    await LanguageNotifier.instance.initialize();
  }

  final listenable = Listenable.merge([
    LanguageNotifier.instance.localeNotifier,
    ThemeNotifier.instance.themeModeNotifier,
  ]);
}
