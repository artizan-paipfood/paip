import 'package:core/core.dart';

abstract interface class IAddressApi {
  Future<AddressEntity> getByEstablishmentId(String id);
  Future<List<AddressEntity>> getByUserId(String id);
  Future<({String city, String country})> getByCityAndCountry(String city, String country);
  Future<AddressEntity> upsert({required AddressEntity address});
  Future<void> deleteById(String id);
}

class AddressApi implements IAddressApi {
  final IClient client;
  AddressApi({
    required this.client, 
  });
  final table = 'address';
  @override
  Future<void> deleteById(String id) async {
    await client.delete("/rest/v1/address?id=eq.$id");
  }

  @override
  Future<AddressEntity> getByEstablishmentId(String id) async {
    final request = await client.get("/rest/v1/address?establishment_id=eq.$id&select=*");
    final List list = request.data;
    final List<AddressEntity> address = list.map<AddressEntity>(
      (address) {
        return AddressEntity.fromMap(address);
      },
    ).toList();
    return address.first;
  }

  @override
  Future<List<AddressEntity>> getByUserId(String id) async {
    final request = await client.get("/rest/v1/address?user_id=eq.$id&select=*");
    final List list = request.data;
    final List<AddressEntity> address = list.map<AddressEntity>(
      (address) {
        return AddressEntity.fromMap(address);
      },
    ).toList();
    return address;
  }

  @override
  Future<AddressEntity> upsert({required AddressEntity address}) async {
    final request = await client.auth().post("/rest/v1/rpc/func_upsert_address", data: {"p_json": address.toMap()});
    return AddressEntity.fromMap(request.data);
  }

  @override
  Future<({String city, String country})> getByCityAndCountry(String city, String country) async {
    final request = await client.post(
      "/rest/v1/rpc/func_get_city_and_country",
      data: {"p_city": city, "p_country": country},
    );
    final data = request.data;
    return (city: data['city'].toString(), country: data['country'].toString());
  }
}
