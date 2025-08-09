import 'dart:io';
import 'package:core_flutter/core_flutter.dart';

import '../../../../paipfood_package.dart';

late BoxCollection collection;

class LocalStorageHive implements ILocalStorage {
  static final LocalStorageHive _instance = LocalStorageHive._singleton();
  factory LocalStorageHive() => _instance;
  LocalStorageHive._singleton();

  final logger = Log(logger: Logger());

  static Future<String> _getPath({bool collectionPath = false}) async {
    String path = "";
    Directory? dir;
    if (isWeb) {
      path = "/";
    } else if (isAndroid) {
      dir = await getExternalStorageDirectory();
      path = dir?.path ?? '/';
    } else if (isIOS) {
      dir = await getApplicationDocumentsDirectory();
      path = dir.path;
    } else {
      dir = await getApplicationSupportDirectory();
      path = dir.path;
    }
    if (collectionPath) return join(path, 'hive_dbpaip');
    path = join(path, 'hive_db');
    return path;
  }

  static Future<String> getPath() async {
    return await _getPath(collectionPath: true);
  }

  static Future<void> init(Set<String> boxNames) async {
    final path = await _getPath();
    Hive.init(path);
    collection = await BoxCollection.open(
      "paip",
      boxNames,
      path: path,
    );
  }

  @override
  Future<void> delete(String boxId, {required List<String> keys}) async {
    try {
      final box = await collection.openBox<Map>(boxId);
      await box.deleteAll(keys);
      _logInfos(boxId, "DELETE", key: keys.toString());
    } catch (e) {
      logger.e('Error during delete operation: $e');
    }
  }

  @override
  Future<Map?> get(String boxId, {required String key}) async {
    try {
      final box = await collection.openBox<Map>(boxId);
      final result = await box.get(key);
      _logInfos(boxId, "GET", key: key, value: result);
      return result;
    } catch (e) {
      logger.e('Error during get operation: $e');
      return null;
    }
  }

  @override
  Future<void> put(String boxId, {required String key, required Map value, bool transaction = false}) async {
    try {
      final box = await collection.openBox<Map>(boxId);
      await box.put(key, value);
      _logInfos(boxId, "PUT", key: key, value: value);
    } catch (e) {
      logger.e('Error during put operation: $e');
    }
  }

  @override
  Future<void> putTransaction(String boxId, {required List<Map> values, String? key}) async {
    try {
      final box = await collection.openBox<Map>(boxId);
      await collection.transaction(
        () async {
          for (var e in values) {
            await box.put(e[key ?? 'id'], e);
          }
        },
        boxNames: [boxId],
      );
      _logInfos(boxId, "PUT_TRANSACTION", key: boxId, value: values.toString());
    } catch (e) {
      logger.e('Error during putTransaction operation: $e');
    }
  }

  @override
  Future<Map?> getAll(String boxId) async {
    try {
      final box = await collection.openBox<Map>(boxId);
      final content = await box.getAllValues();
      final result = Map.fromEntries(content.entries);
      _logInfos(boxId, "GETALL", key: boxId, value: "${result.length}");
      return result;
    } catch (e) {
      logger.e('Error during getAll operation: $e');
      return null;
    }
  }

  @override
  Future<Map?> getAllByKeys(String boxId, {required List<String> keys}) async {
    try {
      final box = await collection.openBox<Map>(boxId);
      final content = await box.getAll(keys);
      final result = Map.fromIterable(content);
      _logInfos(boxId, "GETALLBYKEYS", key: boxId, value: "${result.length}");
      return result;
    } catch (e) {
      logger.e('Error during getAllByKeys operation: $e');
      return null;
    }
  }

  void _logInfos(String box, String method, {String? key, dynamic value}) {
    logger.d('Method: $method \nBox:$box \nKey: $key \nvalue: $value');
  }

  Future<void> openBox(String name) async {
    await collection.openBox<Map>(name);
  }

  Future<void> closeBox(String name) async {
    try {
      final bool boxExist = await Hive.boxExists(name);
      if (boxExist) {
        final box = Hive.box<Map>(name);
        await box.close();
      }
    } catch (e) {
      logger.e('Error during closeBox operation: $e');
    }
  }

  @override
  Future<void> clearBox(String boxId) async {
    try {
      final box = await collection.openBox<Map>(boxId);
      await box.clear();
      _logInfos(boxId, "CLEAR");
    } catch (e) {
      logger.e('Error during clearBox operation: $e');
    }
  }

  @override
  Future<void> clearDatabase() async {
    try {
      for (var boxName in collection.boxNames) {
        final box = await collection.openBox<Map>(boxName);
        await box.clear();
      }
    } catch (e) {
      logger.e('Error during clearDatabase operation: $e');
    }
  }
}
