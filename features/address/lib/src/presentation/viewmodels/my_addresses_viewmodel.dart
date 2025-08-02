import 'package:address/src/data/services/my_position_service.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';

class MyAddressesViewmodel {
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _isLoading;

  bool _locationPermission = false;
  bool get locationPermission => _locationPermission;

  AddressEntity? _myCurrentAddress;
  AddressEntity? get myCurrentAddress => _myCurrentAddress;

  Future<void> initialize() async {
    _isLoading.value = true;
    _locationPermission = await MyPositionService.verifyPermission();
    if (_locationPermission) await getMyPosition();
    _isLoading.value = false;
  }

  Future<void> verifyLocationPermission() async {
    _locationPermission = await MyPositionService.verifyPermission().catchError((_) => false);
  }

  Future<void> getMyPosition() async {
    final myPosition = await MyPositionService.myPosition();

    final places = await placemarkFromCoordinates(myPosition.latitude, myPosition.longitude);
    if (places.isNotEmpty) {
      final place = places.first;
      _myCurrentAddress = AddressEntity(
        id: Uuid().v4(),
        country: place.country ?? '',
        state: place.administrativeArea ?? '',
        city: place.locality ?? '',
        neighborhood: place.subLocality ?? '',
        street: place.street ?? '',
        number: place.subThoroughfare ?? '',
        address: place.thoroughfare ?? '',
        zipCode: place.postalCode ?? '',
        lat: myPosition.latitude,
        long: myPosition.longitude,
      );
    }
  }
}
