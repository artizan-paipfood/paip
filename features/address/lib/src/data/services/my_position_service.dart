import 'dart:async';
import 'package:address/src/data/events/address_events.dart';
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
  final IIpApi ipApi;
  MyPositionService({required this.ipApi});

  final _geolocatorPlatform = GeolocatorPlatform.instance;

  AddressEntity? _address;

  Future<AddressEntity?> myCurrentPositionWhithAddress() async {
    try {
      if (_address != null) return _address!;
      final permission = await hasLocationPermission();
      if (permission != AppLocationPermission.enabled) {
        _address = await getAddressByIp();
        ModularEvent.fire(MyPositionAddressEvent(address: _address!));
        return _address!;
      }
      final myPosition = await _geolocatorPlatform.getCurrentPosition();
      _address = await getAddressByLatLng(myPosition.latitude, myPosition.longitude);
      ModularEvent.fire(MyPositionAddressEvent(address: _address!));
      return _address!;
    } catch (e) {
      return null;
    }
  }

  Future<Stream<Position>> myPositionStream({int distanceFilter = 50}) async {
    final settings = LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: distanceFilter);
    return _geolocatorPlatform.getPositionStream(locationSettings: settings);
  }

  Future<AppLocationPermission> hasLocationPermission() async {
    try {
      final bool serviceEnable = await _geolocatorPlatform.isLocationServiceEnabled();
      if (serviceEnable == false) {
        final permission = await _geolocatorPlatform.requestPermission();
        if (permission == LocationPermission.denied) return AppLocationPermission.denied;
        if (permission == LocationPermission.deniedForever) return AppLocationPermission.deniedForever;
      }
      final permission = await _geolocatorPlatform.checkPermission().timeout(2.seconds);
      return AppLocationPermission.fromGeolocatorPermission(permission);
    } catch (e) {
      return AppLocationPermission.denied;
    }
  }

  Future<AddressEntity?> getAddressByLatLng(double lat, double lng) async {
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
      );
    }
    return null;
  }

  Future<AddressEntity> getAddressByIp() async {
    final ipApiResponse = await ipApi.get();
    return AddressEntity(
      id: Uuid().v4(),
      country: ipApiResponse.countryCode,
      state: ipApiResponse.countryCode,
      city: ipApiResponse.countryCode,
      neighborhood: ipApiResponse.countryCode,
      street: ipApiResponse.countryCode,
      number: ipApiResponse.countryCode,
      address: ipApiResponse.countryCode,
      zipCode: ipApiResponse.countryCode,
      lat: ipApiResponse.lat,
      long: ipApiResponse.lon,
      countryCode: ipApiResponse.countryCode,
    );
  }
}
