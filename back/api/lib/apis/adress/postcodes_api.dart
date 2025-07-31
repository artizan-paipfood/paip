import 'package:api/dtos/postcode.dart';
import 'package:core/core.dart';

class PostCodesApi {
  final IClient client;
  PostCodesApi({required this.client});

  Future<AddressModel> getAddressByPostalCode({required String postalCode}) async {
    final response = await client.get('https://api.postcodes.io/postcodes/$postalCode');
    final data = response.data;
    final cepAwesomeapi = Postcode.fromMap(data['result']);
    return cepAwesomeapi.toAddressModel();
  }
}
