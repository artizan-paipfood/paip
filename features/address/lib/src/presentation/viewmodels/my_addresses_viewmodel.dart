import 'package:address/src/data/services/my_position_service.dart';
import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

class MyAddressesViewmodel {
  final IAuthApi authApi;
  final IAddressApi addressApi;
  MyAddressesViewmodel({required this.authApi, required this.addressApi});

  final ValueNotifier<bool> _isLoading = ValueNotifier(true);
  ValueNotifier<bool> get loading => _isLoading;

  AppLocationPermission _locationPermission = AppLocationPermission.denied;
  AppLocationPermission get locationPermission => _locationPermission;

  AddressEntity? _myCurrentAddress;
  AddressEntity? get myCurrentAddress => _myCurrentAddress;

  Future<void> initialize() async {
    _isLoading.value = true;
    _locationPermission = await MyPositionService.verifyPermission();
    if (_locationPermission == AppLocationPermission.enabled) await getMyPosition();
    _isLoading.value = false;
  }

  Future<void> verifyLocationPermission() async {
    _locationPermission = await MyPositionService.verifyPermission().catchError((_) => AppLocationPermission.denied);
  }

  Future<void> getMyPosition() async {
    final myPosition = await MyPositionService.myPosition();
    if (myPosition == null) return;
    _myCurrentAddress = await MyPositionService.getAddressByLatLng(myPosition.lat, myPosition.lng);
  }

  bool isSelected({required String addressId}) {
    return UserMe.me?.data.selectedAddressId == addressId;
  }

  Future<void> selectAddress(AddressEntity address) async {
    await authApi.updateMe(me: UserMe.me!.copyWith(metadata: UserMe.me!.metadata.copyWith(selectedAddressId: address.id)));
    await UserMe.refresh(userId: UserMe.me!.id);
  }

  Future<void> deleteAddress(AddressEntity address) async {
    await addressApi.deleteById(address.id);
    await UserMe.refresh(userId: UserMe.me!.id);
  }
}
