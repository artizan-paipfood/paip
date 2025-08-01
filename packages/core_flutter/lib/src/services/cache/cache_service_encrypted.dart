import 'dart:convert';
import 'package:core_flutter/core_flutter.dart';
import 'package:core/core.dart';

class CacheServiceEncrypted implements ICacheService<Map<String, dynamic>> {
  final SharedPreferences sharedPreferences;
  final String encryptKey;
  CacheServiceEncrypted({required this.sharedPreferences, required this.encryptKey});

  @override
  Future<void> clear() async {
    await sharedPreferences.clear();
  }

  @override
  Future<Map<String, dynamic>?> get({required String box}) async {
    final json = sharedPreferences.getString(box);
    if (json == null) return null;
    final decryptedJson = _decrypt(json);
    if (decryptedJson == null) {
      await delete(box: box);
      return null;
    }
    final Map<String, dynamic> data = jsonDecode(decryptedJson);
    return await _parseData(box: box, data: data);
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
    if (expiresAt != null) data['expiresAt'] = expiresAt.toIso8601String();

    final json = jsonEncode(data);
    final encryptedJson = _encrypt(json);
    await sharedPreferences.setString(box, encryptedJson);
  }

  String _encrypt(String data) {
    return Aes256.encrypt(text: data, passphrase: encryptKey);
  }

  String? _decrypt(String encryptedData) {
    return Aes256.decrypt(encrypted: encryptedData, passphrase: encryptKey);
  }
}
