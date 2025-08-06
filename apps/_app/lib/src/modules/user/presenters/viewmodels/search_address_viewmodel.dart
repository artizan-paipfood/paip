import 'package:flutter/widgets.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SearchAddressConstants {
  static const int searchMinLength = 3;
  static const int debounceTimeMs = 700;
  static const AutoCompleteProvider autoCompleteProvider = AutoCompleteProvider.google;
}

class SearchAddressViewmodel extends ChangeNotifier {
  final IAddressApi addressApi;

  SearchAddressViewmodel({required this.addressApi});

  final _debouncer = Debounce<List<AddressModel>>(milliseconds: 700);

  ValueNotifier<bool> get isLoadingNotifier => _debouncer.isLoadingNotifier;
  List<AddressModel> _addresses = [];

  List<AddressModel> get addresses => _addresses;
  bool _isSearchingAddress = false;
  bool get isSearchingAddress => _isSearchingAddress;
  void setSearchingAddress(bool value) {
    _isSearchingAddress = value;
    notifyListeners();
  }

  AddressEntity? _selectedAddress;
  AddressEntity? get selectedAddress => _selectedAddress;

  Future<AddressEntity> selectAddress({required AddressModel address, required double? latReference, required double? lonReference}) async {
    setSearchingAddress(false);
    if (address.isValid()) return AddressEntity.fromAddressModel(address);
    return _geocodeAddress(address: address, latReference: latReference, lonReference: lonReference);
  }

  Future<AddressEntity> _geocodeAddress({required AddressModel address, required double? latReference, required double? lonReference}) async {
    final response = await addressApi.geocode(
        request: GeocodeRequest(
      query: address.formattedAddress,
      provider: SearchAddressConstants.autoCompleteProvider,
      locale: LocaleNotifier.instance.locale,
      address: address,
      lat: latReference,
      lon: lonReference,
    ));
    final entity = AddressEntity.fromAddressModel(response);
    return entity;
  }

  void reset() {
    _addresses = [];
    _selectedAddress = null;
    setSearchingAddress(false);
    notifyListeners();
  }

  Future<List<AddressModel>> autoComplete({required String query, required double? latReference, required double? lonReference}) async {
    if (!_isSearchingAddress) setSearchingAddress(true);
    final result = await _debouncer.startTimer(
      value: query,
      length: 3,
      onComplete: () async {
        return await addressApi.autocomplete(
          request: AutoCompleteRequest(
            query: query,
            locale: LocaleNotifier.instance.locale,
            provider: SearchAddressConstants.autoCompleteProvider,
            lat: latReference,
            lon: lonReference,
          ),
        );
      },
    );
    _addresses = result ?? [];
    notifyListeners();
    return result ?? <AddressModel>[];
  }

  Future<AddressEntity> postalCode({required String postalCode, required double? latReference, required double? lonReference}) async {
    final address = await addressApi.postalcodeGeocode(
      request: PostcodeGeocodeRequest(
        postalCode: postalCode,
        provider: SearchAddressConstants.autoCompleteProvider,
        locale: LocaleNotifier.instance.locale,
        lat: latReference,
        lon: lonReference,
      ),
    );
    final entity = AddressEntity.fromAddressModel(address);
    _selectedAddress = entity;
    return entity;
  }
}
