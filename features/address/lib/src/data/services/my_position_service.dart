import 'dart:async';

import 'package:address/i18n/gen/strings.g.dart';
import 'package:address/src/utils/exceptions/location_permission_exception.dart';
import 'package:geolocator/geolocator.dart';

class MyPositionService {
  MyPositionService._();

  static Future<Position> myPosition() async {
    await verifyPermission();
    return await Geolocator.getCurrentPosition();
  }

  static Future<Stream<Position>> myPositionStream({int distanceFilter = 50}) async {
    await verifyPermission();
    final settings = LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: distanceFilter);
    return Geolocator.getPositionStream(locationSettings: settings);
  }

  static Future<bool> verifyPermission() async {
    final bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error(LocationPermissionException(t.servicos_de_localizacao_desativados, LocationPermissionExceptionType.disabled));
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    switch (permission) {
      case LocationPermission.denied:
        return Future.error(LocationPermissionException(t.permissao_de_localizacao_negada, LocationPermissionExceptionType.denied));
      case LocationPermission.deniedForever:
        return Future.error(LocationPermissionException(t.permissao_de_localizacao_negada_permanentemente, LocationPermissionExceptionType.deniedForever));
      default:
    }
    return true;
  }
}
