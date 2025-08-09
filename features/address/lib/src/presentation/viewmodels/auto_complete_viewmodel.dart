import 'package:address/src/data/services/my_position_service.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';

class AutoCompleteViewmodel extends ChangeNotifier {
  final SearchAddressApi searchAddressApi;
  final MyPositionService myPositionService;

  AutoCompleteViewmodel({required this.searchAddressApi, required this.myPositionService});

  final Debounce _debounce = Debounce(milliseconds: 1000);

  List<AddressModel> _addresses = [];

  List<AddressModel> get addresses => _addresses;
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ValueNotifier<bool> get load => _isLoading;

  String _lastQuery = '';

  Future<AddressEntity> selectAddress(AddressModel address) async {
    if (address.isValid()) return AddressEntity.fromAddressModel(address);

    final result = await searchAddressApi.geocode(
      request: GeocodeRequest(
        query: address.formattedAddress,
        locale: AppLocaleCode.br,
        address: address,
      ),
    );
    return AddressEntity.fromAddressModel(result);
  }

  void autocomplete({required String query}) async {
    _debounce.run(() async {
      if (query.isEmpty) {
        _addresses = [];
        notifyListeners();
        return;
      }
      if (query.length < 5 || query == _lastQuery) return;
      _lastQuery = query;
      _isLoading.value = true;
      try {
        final position = await myPositionService.myCurrentPositionWhithAddress();

        final response = await searchAddressApi.autocomplete(
          request: AutoCompleteRequest(
            query: query,
            locale: AppLocaleCode.br,
            lat: position?.lat,
            lon: position?.long,
          ),
        );
        _addresses = response;
      } finally {
        _isLoading.value = false;
      }
    });
  }
}
