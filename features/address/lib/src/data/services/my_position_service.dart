import 'dart:async';
import 'package:address/i18n/gen/strings.g.dart';
import 'package:address/src/data/events/position_events.dart';
import 'package:address/src/utils/exceptions/location_permission_exception.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MyPositionService {
  MyPositionService._();

  static late final IIpApi ipApi;

  static Position? _position;

  static Future<Position> myPosition() async {
    if (_position != null) {
      return _position!;
    }
    try {
      await verifyPermission();
    } on LocationPermissionException catch (_) {
      final ipApiResponse = await ipApi.get();
      _position = Position(latitude: ipApiResponse.lat, longitude: ipApiResponse.lon, timestamp: DateTime.now(), accuracy: 10, altitude: 0, altitudeAccuracy: 0, heading: 0, headingAccuracy: 0, speed: 0, speedAccuracy: 0);
      ModularEvent.fire(MyPositionEvent(lat: _position!.latitude, lng: _position!.longitude));
      return _position!;
    }
    _position = await Geolocator.getCurrentPosition();
    ModularEvent.fire(MyPositionEvent(lat: _position!.latitude, lng: _position!.longitude));
    return _position!;
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

  static Future<AddressEntity?> getAddressByLatLng(double lat, double lng) async {
    final places = await placemarkFromCoordinates(lat, lng);
    if (places.isNotEmpty) {
      final place = places.first;
      return AddressEntity(
        id: Uuid().v4(),
        country: place.country ?? '',
        state: place.administrativeArea ?? '',
        city: place.locality ?? '',
        neighborhood: place.subLocality ?? '',
        street: place.street ?? '',
        number: place.subThoroughfare ?? '',
        address: place.thoroughfare ?? '',
        zipCode: place.postalCode ?? '',
        lat: lat,
        long: lng,
        countryCode: place.isoCountryCode ?? '',
        mainText: '${place.name ?? ''}|${place.subLocality ?? ''}'.split('|').where((e) => e.trim().isNotEmpty).toList().join(' - '),
        secondaryText: '${place.postalCode ?? ''}|${place.subAdministrativeArea ?? ''}'.split('|').where((e) => e.trim().isNotEmpty).toList().join(' - '),
      );
    }
    return null;
  }
}
