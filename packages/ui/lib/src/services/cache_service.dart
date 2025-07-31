import 'dart:convert';

import 'package:paipfood_package/paipfood_package.dart';

abstract class ICacheService<T> {
  Future<void> save({required String box, required Map<String, dynamic> data, Duration? expiresIn});
  Future<T?> get({required String box});
  Future<void> delete({required String box});
  Future<void> clear();
}

class CacheService implements ICacheService<Map<String, dynamic>> {
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
    final DateTime? expiresIn = data['expiresIn'] != null ? DateTime.fromMillisecondsSinceEpoch(data['expiresIn']) : null;
    if (expiresIn != null) {
      final now = DateTime.now();
      final isExpired = now.isAfter(expiresIn);
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
  Future<void> save({required String box, required Map<String, dynamic> data, Duration? expiresIn}) async {
    if (expiresIn != null) {
      data['expiresIn'] = DateTime.now().add(expiresIn).millisecondsSinceEpoch;
    }
    final json = jsonEncode(data);
    await sharedPreferences.setString(box, json);
  }
}
