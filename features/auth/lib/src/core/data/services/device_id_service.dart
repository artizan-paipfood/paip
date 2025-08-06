import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';

class DeviceIdService {
  final ICacheService cache;

  DeviceIdService({required this.cache});

  static const String _box = 'paipfood_device_id';

  Future<String> get() async {
    final deviceId = await cache.get(box: _box);
    if (deviceId == null) {
      final newDeviceId = Uuid().v4();
      await cache.save(box: _box, data: {'id': newDeviceId});
      return newDeviceId;
    }
    return deviceId['id'];
  }
}
