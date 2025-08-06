import 'package:core/core.dart';

abstract interface class ISearchAddressApi {
  Future<List<AddressModel>> autocomplete({required AutoCompleteRequest request});
  Future<AddressModel> geocode({required GeocodeRequest request});
  Future<AddressModel> postalcodeGeocode({required PostcodeGeocodeRequest request});
  Future<DeliveryTaxResponse> deliveryTax({required DeliveryTaxRequest request});
  Future<GetDistanceResponse> getDistance({required GetDistanceRequest request});
}

class SearchAddressApi implements ISearchAddressApi {
  final IClient client;
  SearchAddressApi({required this.client});

  @override
  Future<List<AddressModel>> autocomplete({required AutoCompleteRequest request}) async {
    final response = await client.post("/v1/address/auto_complete", data: request.toMap());
    final List list = response.data;
    return list.map((e) => AddressModel.fromMap(e)).toList();
  }

  @override
  Future<AddressModel> geocode({required GeocodeRequest request}) async {
    final response = await client.post("/v1/address/geocode", data: request.toMap());
    return AddressModel.fromMap(response.data);
  }

  @override
  Future<AddressModel> postalcodeGeocode({required PostcodeGeocodeRequest request}) async {
    final response = await client.post("/v1/address/postalcode_geocode", data: request.toMap());
    return AddressModel.fromMap(response.data);
  }

  @override
  Future<DeliveryTaxResponse> deliveryTax({required DeliveryTaxRequest request}) async {
    final response = await client.post("/v1/address/delivery_tax", data: request.toMap());
    return DeliveryTaxResponse.fromMap(response.data);
  }

  @override
  Future<GetDistanceResponse> getDistance({required GetDistanceRequest request}) async {
    final response = await client.post('/v1/address/get_distance', data: request.toMap());
    return GetDistanceResponse.fromMap(response.data);
  }
}
