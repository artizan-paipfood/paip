import 'dart:convert';

import 'package:hive_ce/hive.dart';

class MapboxSessiontoken extends HiveObject {
  final String token;
  final DateTime expiresAt;

  MapboxSessiontoken({
    required this.token,
    required this.expiresAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'expiresAt': expiresAt.millisecondsSinceEpoch,
    };
  }

  factory MapboxSessiontoken.fromMap(Map<String, dynamic> map) {
    return MapboxSessiontoken(
      token: map['token'] ?? '',
      expiresAt: DateTime.fromMillisecondsSinceEpoch(map['expiresAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MapboxSessiontoken.fromJson(String source) => MapboxSessiontoken.fromMap(json.decode(source));
}
