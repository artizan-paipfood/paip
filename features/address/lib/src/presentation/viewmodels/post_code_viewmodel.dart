import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';

class PostCodeViewmodel {
  final ISearchAddressApi searchAddressApi;

  PostCodeViewmodel({required this.searchAddressApi});

  AddressEntity? _address;

  Future<AddressEntity> searchByPostcode(String postcode) async {
    final result = await searchAddressApi.postalcodeGeocode(
      request: PostcodeGeocodeRequest(
        postalCode: postcode,
        provider: AutoCompleteProvider.radar,
        locale: AppLocale.locale,
      ),
    );
    _address = AddressEntity.fromAddressModel(result);
    return _address!;
  }
}
