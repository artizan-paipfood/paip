import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';

class DeviceId {
  static late final ICacheService cache;

  static const String _box = 'paipfood_device_id';

  static void initialize(ICacheService cache) {
    DeviceId.cache = cache;
  }

  static String _id = '';

  static Future<String> get() async {
    if (_id.isNotEmpty) return _id;
    final deviceId = await cache.get(box: _box);
    if (deviceId == null) {
      final newDeviceId = Uuid().v4();
      await cache.save(box: _box, data: {'id': newDeviceId});
      return newDeviceId;
    }
    _id = deviceId['id'];
    return _id;
  }
}
