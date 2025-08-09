import 'dart:async';
import 'package:address/src/.i18n/gen/strings.g.dart';
import 'package:address/src/data/events/position_events.dart';
import 'package:address/src/utils/exceptions/location_permission_exception.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ui/ui.dart';

enum AppLocationPermission {
  enabled,
  denied,
  deniedForever,
  disabled;

  static AppLocationPermission fromGeolocatorPermission(LocationPermission permission) {
    switch (permission) {
      case LocationPermission.denied:
        return AppLocationPermission.denied;
      case LocationPermission.deniedForever:
        return AppLocationPermission.deniedForever;
      case LocationPermission.always:
        return AppLocationPermission.enabled;
      case LocationPermission.whileInUse:
        return AppLocationPermission.enabled;
      case LocationPermission.unableToDetermine:
        return AppLocationPermission.disabled;
    }
  }
}

class AppPosition {
  final double lat;
  final double lng;
  final String? countryCode;
  AppPosition({required this.lat, required this.lng, this.countryCode});
}

class MyPositionService {
  MyPositionService._();

  static late final IIpApi ipApi;

  static AppPosition? _position;

  static Future<AppPosition?> myPosition() async {
    if (_position != null) return _position!;
    final permission = await verifyPermission();
    if (isWeb || permission != AppLocationPermission.enabled) {
      final ipApiResponse = await ipApi.get();
      _position = AppPosition(lat: ipApiResponse.lat, lng: ipApiResponse.lon, countryCode: ipApiResponse.countryCode);
      return _position;
    }

    final geolocation = await Geolocator.getCurrentPosition();
    _position = AppPosition(lat: geolocation.latitude, lng: geolocation.longitude);
    return _position!;
  }

  static Future<Stream<Position>> myPositionStream({int distanceFilter = 50}) async {
    await verifyPermission();
    final settings = LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: distanceFilter);
    return Geolocator.getPositionStream(locationSettings: settings);
  }

  static Future<AppLocationPermission> verifyPermission() async {
    try {
      final bool serviceEnable = await Geolocator.isLocationServiceEnabled();
      if (serviceEnable == false) return AppLocationPermission.disabled;

      LocationPermission permission = await Geolocator.checkPermission().timeout(2.seconds);
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      return AppLocationPermission.fromGeolocatorPermission(permission);
    } catch (e) {
      return AppLocationPermission.denied;
    }
  }

  static Future<AddressEntity?> getAddressByLatLng(double lat, double lng) async {
    if (isWeb) return null;
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
