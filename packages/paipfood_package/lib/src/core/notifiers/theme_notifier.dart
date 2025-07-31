import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ThemeNotifier {
  static ThemeNotifier? _instance;
  ThemeNotifier._();
  static ThemeNotifier get instance => _instance ??= ThemeNotifier._();

  final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.system);

  ThemeMode get themeMode => themeModeNotifier.value;

  ILocalStorage get _cache => LocalStorageSharedPreferences.instance;

  void toggleMode() {
    themeModeNotifier.value = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _cache.put(ThemeDto.box, key: ThemeDto.box, value: ThemeDto(themeMode: themeModeNotifier.value).toMap());
  }

  Future<void> initialize() async {
    final data = await _cache.get(ThemeDto.box, key: ThemeDto.box);
    if (data != null) {
      final themeDto = ThemeDto.fromMap(data);
      themeModeNotifier.value = themeDto.themeMode;
    }
  }
}

class ThemeDto {
  final ThemeMode themeMode;

  ThemeDto({required this.themeMode});

  static String box = 'paip_theme';

  ThemeDto copyWith({
    ThemeMode? themeMode,
  }) {
    return ThemeDto(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'theme_mode': themeMode.name,
    };
  }

  factory ThemeDto.fromMap(Map map) {
    return ThemeDto(
      themeMode: ThemeMode.values.firstWhere((e) => e.name == map['theme_mode']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ThemeDto.fromJson(String source) => ThemeDto.fromMap(json.decode(source));
}
