import 'package:core/core.dart';

import 'package:paipfood_package/paipfood_package.dart';
import 'package:paipfood_package/src/core/models/adapters/address/address_country_adapter.dart';

abstract interface class IAddressRepository {
  Future<AddressEntity> getByEstablishmentId(String id);
  Future<List<AddressEntity>> getByUserId(String id);
  Future<AddressCountryAdapter> getByCityAndCountry(String city, String country);
  Future<AddressEntity> upsert({required AddressEntity address, required AuthModel auth});
  Future<void> deleteById(String id);
}

class AddressRepository implements IAddressRepository {
  final IClient http;
  AddressRepository({
    required this.http,
  });
  final table = 'address';
  @override
  Future<void> deleteById(String id) async {
    await http.delete("/rest/v1/address?id=eq.$id");
  }

  @override
  Future<AddressEntity> getByEstablishmentId(String id) async {
    final request = await http.get("/rest/v1/address?establishment_id=eq.$id&select=*");
    final List list = request.data;
    final List<AddressEntity> address = list.map<AddressEntity>((address) {
      return AddressEntity.fromMap(address);
    }).toList();
    return address.first;
  }

  @override
  Future<List<AddressEntity>> getByUserId(String id) async {
    final request = await http.get("/rest/v1/address?user_id=eq.$id&select=*");
    final List list = request.data;
    final List<AddressEntity> address = list.map<AddressEntity>((address) {
      return AddressEntity.fromMap(address);
    }).toList();
    return address;
  }

  @override
  Future<AddressEntity> upsert({required AddressEntity address, required AuthModel auth}) async {
    final request = await http.post("/rest/v1/rpc/func_upsert_address", data: {"p_json": address.toMap()});
    return AddressEntity.fromMap(request.data);
  }

  @override
  Future<AddressCountryAdapter> getByCityAndCountry(String city, String country) async {
    final request = await http.post(
      "/rest/v1/rpc/func_get_city_and_country",
      data: {"p_city": city, "p_country": country},
    );

    return AddressCountryAdapter.fromMap(request.data);
  }
}
