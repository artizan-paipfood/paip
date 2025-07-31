import 'dart:convert';
import 'dart:core';

import 'package:paipfood_package/paipfood_package.dart';

class LocalStorageSharedPreferences implements ILocalStorage {
  static LocalStorageSharedPreferences? _instance;

  LocalStorageSharedPreferences._();
  static LocalStorageSharedPreferences get instance => _instance ??= LocalStorageSharedPreferences._();

  final logger = Logger();

  late SharedPreferences sharedPreferences;
  Future<void> initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> delete(String boxId, {required List<String> keys}) async {
    for (var key in keys) {
      await sharedPreferences.remove('$boxId-$key');
    }
    _logInfos(boxId, "DELETE", key: keys.toString());
  }

  @override
  Future<Map?> get(String boxId, {required String key}) async {
    final jsonString = sharedPreferences.getString('$boxId-$key');
    final result = jsonString != null ? jsonDecode(jsonString) as Map : null;
    _logInfos(boxId, "GET", key: key, value: result);
    return result;
  }

  @override
  Future<void> put(String boxId, {required String key, required Map value, bool transaction = false}) async {
    final jsonString = jsonEncode(value);
    await sharedPreferences.setString('$boxId-$key', jsonString);
    _logInfos(boxId, "PUT", key: key, value: value);
  }

  @override
  Future<void> putTransaction(String boxId, {required List<Map> values, String? key}) async {
    await Future.wait(values.map((e) async {
      final jsonString = jsonEncode(e);
      await sharedPreferences.setString('$boxId-${e[key ?? 'id']}', jsonString);
    }));
    _logInfos(boxId, "PUT_TRANSACTION", key: boxId, value: values.toString());
  }

  @override
  Future<Map?> getAll(String boxId) async {
    final allKeys = sharedPreferences.getKeys().where((k) => k.startsWith('$boxId-'));
    final Map<String, dynamic> result = {};
    for (var key in allKeys) {
      final jsonString = sharedPreferences.getString(key);
      if (jsonString != null) {
        result[key.replaceFirst('$boxId-', '')] = jsonDecode(jsonString);
      }
    }
    _logInfos(boxId, "GETALL", key: boxId, value: "${result.length}");
    return result;
  }

  @override
  Future<Map?> getAllByKeys(String boxId, {required List<String> keys}) async {
    final Map<String, dynamic> result = {};
    for (var key in keys) {
      final jsonString = sharedPreferences.getString('$boxId-$key');
      if (jsonString != null) {
        result[key] = jsonDecode(jsonString);
      }
    }
    _logInfos(boxId, "GETALLBYKEYS", key: boxId, value: "${result.length}");
    return result;
  }

  void _logInfos(String box, String method, {String? key, dynamic value}) {
    logger.d('Method: $method \nBox:$box \nKey: $key \nvalue: $value');
  }

  Future<void> openBox(String name) async {
    // No equivalent needed for SharedPreferences
  }

  Future<void> closeBox(String name) async {
    // No equivalent needed for SharedPreferences
  }

  @override
  Future<void> clearBox(String boxId) async {
    final allKeys = sharedPreferences.getKeys().where((k) => k.startsWith('$boxId-'));
    for (var key in allKeys) {
      await sharedPreferences.remove(key);
    }
    _logInfos(boxId, "CLEAR");
  }

  @override
  Future<void> clearDatabase() async {
    await sharedPreferences.clear();
  }
}
