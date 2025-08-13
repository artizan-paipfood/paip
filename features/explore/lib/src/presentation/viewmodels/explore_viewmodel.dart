import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ExploreViewmodel {
  final IEstablishmentApi establishmentApi;
  ExploreViewmodel({
    required this.establishmentApi,
  });

  final ValueNotifier<bool> _isLoad = ValueNotifier(false);
  bool get load => _isLoad.value;

  final ValueNotifier<List<EstablishmentExplore>> _establishments = ValueNotifier([]);
  List<EstablishmentExplore> get establishments => _establishments.value;

  Future<void> refreshByLocation({required AddressEntity address}) async {
    _isLoad.value = true;
    final list = await establishmentApi.getEstablishmentByLocation(lat: address.lat!, long: address.long!, radiusKm: 10);
    _establishments.value = list;
    _isLoad.value = false;
  }

  AddressEntity? get selectedAddress => UserMe.me?.addresses.firstWhereOrNull(
        (a) => a.id == UserMe.me?.data.selectedAddressId,
      );
}
