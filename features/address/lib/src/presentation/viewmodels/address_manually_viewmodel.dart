import 'package:address/src/data/events/address_events.dart';
import 'package:address/src/data/services/my_position_service.dart';
import 'package:address/src/domain/models/address_manually_model.dart';
import 'package:address/src/domain/usecases/update_principal_user_address_usecase.dart';
import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';

class AddressManuallyViewmodel extends ChangeNotifier {
  final IAddressApi addressApi;
  final MyPositionService myPositionService;
  final UpdateUserPrincipalAddressUsecase updateUserPrincipalAddressUsecase;
  AddressManuallyViewmodel({required this.addressApi, required this.updateUserPrincipalAddressUsecase, required this.myPositionService});

  final ValueNotifier<bool> _isLoading = ValueNotifier(true);
  ValueNotifier<bool> get loading => _isLoading;
  late AddressManuallyModel _addressManuallyModel;
  AddressManuallyModel get addressManuallyModel => _addressManuallyModel;

  Future<void> initialize({required double lat, required double lng, AddressEntity? address}) async {
    _isLoading.value = true;

    if (address != null) await _initializeWithAddress(address);
    if (address == null) await _initializeWithPosition(lat, lng);

    _isLoading.value = false;

    notifyListeners();
  }

  Future<void> _initializeWithAddress(AddressEntity address) async {
    _addressManuallyModel = AddressManuallyModel(address: address, addressWithoutNumber: false, addressWithoutComplement: false);
  }

  Future<void> _initializeWithPosition(double lat, double lng) async {
    final address = await myPositionService.getAddressByLatLng(lat, lng);
    if (address == null) throw Exception('Address not found');
    _addressManuallyModel = AddressManuallyModel(address: address, addressWithoutNumber: false, addressWithoutComplement: false);
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
    ModularEvent.fire(SelectAddressEvent(address: _addressManuallyModel.address));
  }
}
