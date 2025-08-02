import 'package:address/src/data/services/my_position_service.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

class MyAddressesViewmodel {
  final ValueNotifier<bool> _isLoading = ValueNotifier(true);
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

    _myCurrentAddress = await MyPositionService.getAddressByLatLng(myPosition.latitude, myPosition.longitude);
  }
}
