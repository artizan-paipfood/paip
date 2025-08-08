import 'package:address/src/data/services/my_position_service.dart';
import 'package:address/src/domain/models/address_manually_model.dart';
import 'package:address/src/domain/usecases/update_principal_user_address_usecase.dart';
import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AddressManuallyViewmodel extends ChangeNotifier {
  final IAddressApi addressApi;
  // O nome correto em inglês seria "UpdateUserPrincipalAddressUsecase" ao invés de "UpdateUserPrintipalAddressUsecase".
  final UpdateUserPrincipalAddressUsecase updateUserPrincipalAddressUsecase;
  AddressManuallyViewmodel({required this.addressApi, required this.updateUserPrincipalAddressUsecase});

  final ValueNotifier<bool> _isLoading = ValueNotifier(true);
  ValueNotifier<bool> get loading => _isLoading;
  late AddressManuallyModel _addressManuallyModel;
  AddressManuallyModel get addressManuallyModel => _addressManuallyModel;

  Future<void> initialize(double lat, double lng) async {
    _isLoading.value = true;

    final address = await MyPositionService.getAddressByLatLng(lat, lng);
    if (address == null) throw Exception('Address not found');

    _addressManuallyModel = AddressManuallyModel(address: address, addressWithoutNumber: false, addressWithoutComplement: false);

    _isLoading.value = false;

    notifyListeners();
  }

  void changeAddressManually(AddressManuallyModel value) {
    _addressManuallyModel = value;
    notifyListeners();
  }

  void changeAddressWithoutNumber(bool value) {
    _addressManuallyModel = _addressManuallyModel.copyWith(addressWithoutNumber: value);
    notifyListeners();
  }

  void changeAddressWithoutComplement(bool value) {
    _addressManuallyModel = _addressManuallyModel.copyWith(addressWithoutComplement: value);
    notifyListeners();
  }

  Future<void> saveAddress() async {
    await addressApi.upsert(address: _addressManuallyModel.address.copyWith(userId: UserMe.me!.id));
    await updateUserPrincipalAddressUsecase(_addressManuallyModel.address.id);
    await UserMe.refresh(userId: UserMe.me!.id);
  }
}
