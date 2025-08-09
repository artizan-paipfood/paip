import 'package:core_flutter/core_flutter.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:geolocator/geolocator.dart';

class InitializeWebService {
  InitializeWebService._();

  static Future<void> initialize() async {
    if (!isWeb) return;
    usePathUrlStrategy();
  }
}
