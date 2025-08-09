import 'package:address/src/data/events/address_events.dart';
import 'package:address/src/data/services/my_position_service.dart';
import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong2/latlong.dart';

class MyAddressesViewmodel {
  final IAuthApi authApi;
  final IAddressApi addressApi;
  final MyPositionService myPositionService;
  MyAddressesViewmodel({required this.authApi, required this.addressApi, required this.myPositionService});

  final ValueNotifier<bool> _isLoading = ValueNotifier(true);
  ValueNotifier<bool> get loading => _isLoading;

  final AppLocationPermission _locationPermission = AppLocationPermission.denied;
  AppLocationPermission get locationPermission => _locationPermission;

  AddressEntity? _myPositionAddress;
  AddressEntity? get myPositionAddress => _myPositionAddress;

  Future<void> initialize() async {
    _isLoading.value = true;

    await getMyPosition();
    _isLoading.value = false;
  }

  Future<void> getMyPosition() async {
    _myPositionAddress = await myPositionService.myCurrentPositionWhithAddress();
  }

  bool isSelected({required String addressId}) {
    return UserMe.me?.data.selectedAddressId == addressId;
  }

  Future<void> deleteAddress(AddressEntity address) async {
    await addressApi.deleteById(address.id);
    await UserMe.refresh(userId: UserMe.me!.id);
  }

  List<AddressEntity> myAddresses() {
    final List<AddressEntity> addresses = List<AddressEntity>.from(UserMe.me?.addresses ?? const <AddressEntity>[]);
    final current = _myPositionAddress;
    if (current == null) return addresses;

    final double? currentLat = current.lat;
    final double? currentLng = current.long;
    if (currentLat == null || currentLng == null) return addresses;

    final distance = Distance();
    int compare(AddressEntity a, AddressEntity b) {
      final bool aValid = a.lat != null && a.long != null;
      final bool bValid = b.lat != null && b.long != null;
      if (aValid && !bValid) return -1;
      if (!aValid && bValid) return 1;
      if (!aValid && !bValid) return 0;

      final da = distance(LatLng(currentLat, currentLng), LatLng(a.lat!, a.long!));
      final db = distance(LatLng(currentLat, currentLng), LatLng(b.lat!, b.long!));
      return da.compareTo(db);
    }

    addresses.sort(compare);
    return addresses;
  }

  void selectAddress(AddressEntity address) {
    ModularEvent.fire(SelectAddressEvent(address: address));
  }
}
