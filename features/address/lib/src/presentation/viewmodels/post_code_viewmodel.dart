import 'package:core/core.dart';

class PostCodeViewmodel {
  final ISearchAddressApi searchAddressApi;

  PostCodeViewmodel({required this.searchAddressApi});

  AddressEntity? _address;

  Future<AddressEntity> searchByPostcode(String postcode) async {
    final result = await searchAddressApi.postalcodeGeocode(
      request: PostcodeGeocodeRequest(
        postalCode: postcode,
        provider: AutoCompleteProvider.radar,
        locale: AppLocaleCode.br,
      ),
    );
    _address = AddressEntity.fromAddressModel(result);
    return _address!;
  }
}
