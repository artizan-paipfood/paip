import 'dart:convert';

import 'package:core_flutter/core_flutter.dart';

abstract class ICacheService {
  Future<void> save({required String box, required Map<String, dynamic> data, DateTime? expiresAt});
  Future<Map<String, dynamic>?> get({required String box});
  Future<void> delete({required String box});
  Future<void> clear();
}

class CacheService implements ICacheService {
  final SharedPreferences sharedPreferences;

  CacheService({required this.sharedPreferences});

  @override
  Future<void> clear() async {
    await sharedPreferences.clear();
  }

  @override
  Future<Map<String, dynamic>?> get({required String box}) async {
    final json = sharedPreferences.getString(box);
    if (json == null) return null;
    final Map<String, dynamic> data = jsonDecode(json);

    return _parseData(box: box, data: data);
  }

  Future<Map<String, dynamic>?> _parseData({required String box, required Map<String, dynamic> data}) async {
    final DateTime? expiresAt = data['expiresAt'] != null ? DateTime.parse(data['expiresAt']) : null;
    if (expiresAt != null) {
      final now = DateTime.now();
      final isExpired = now.isAfter(expiresAt);
      if (isExpired) {
        await delete(box: box);
        return null;
      }

      return data;
    }
    return data;
  }

  @override
  Future<void> delete({required String box}) async {
    await sharedPreferences.remove(box);
  }

  @override
  Future<void> save({required String box, required Map<String, dynamic> data, DateTime? expiresAt}) async {
    if (expiresAt != null) {
      data['expiresAt'] = expiresAt.toIso8601String();
    }
    final json = jsonEncode(data);
    await sharedPreferences.setString(box, json);
  }
}
