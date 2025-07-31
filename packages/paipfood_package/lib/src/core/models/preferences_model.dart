import 'dart:convert';
import 'package:paipfood_package/paipfood_package.dart';

class PreferencesModel {
  final String id;
  final String? establishmentId;
  final bool? isDarkMode;
  final String language;
  final String refreshToken;

  PreferencesModel({
    required this.id,
    this.establishmentId,
    this.isDarkMode,
    this.language = 'en',
    this.refreshToken = '',
  });
  static const String box = "paip_preferences";
  Map<String, dynamic> toMap({bool supabase = true}) {
    final map = {'id': id, 'establishment_id': establishmentId, 'is_dark_mode': isDarkMode, 'language': language, 'refresh_token': refreshToken};

    return map;
  }

  factory PreferencesModel.fromMap(Map map) {
    return PreferencesModel(
      id: map['id'] ?? uuid,
      establishmentId: map['establishment_id'],
      isDarkMode: map['is_dark_mode'],
      language: map['language'] ?? 'en',
      refreshToken: map['refresh_token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PreferencesModel.fromJson(String source) => PreferencesModel.fromMap(json.decode(source));

  PreferencesModel copyWith({
    String? id,
    String? establishmentId,
    bool? isDarkMode,
    String? language,
    String? refreshToken,
  }) {
    return PreferencesModel(
      id: id ?? this.id,
      establishmentId: establishmentId ?? this.establishmentId,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      language: language ?? this.language,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
