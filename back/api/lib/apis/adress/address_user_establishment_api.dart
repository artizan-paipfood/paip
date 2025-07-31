import 'package:core/core.dart';

abstract interface class IAddressUserEstablishmentApi {
  Future<AddressUserEstablishmentEntity?> get({required String userAddressId, required String establishmentAddressId});
  Future<AddressUserEstablishmentEntity> create(AddressUserEstablishmentEntity addressUserEstablishment);
  Future<void> delete({required String userAddressId, required String establishmentAddressId});
  Future<void> deleteAllByEstablishmentAddressId({required String establishmentAddressId});
}

class AddressUserEstablishmentApi implements IAddressUserEstablishmentApi {
  final IClient client;
  AddressUserEstablishmentApi({required this.client});
  @override
  Future<AddressUserEstablishmentEntity> create(AddressUserEstablishmentEntity addressUserEstablishment) async {
    final response = await client.post('/rest/v1/address_user_establishment', data: addressUserEstablishment.toMap());
    final List list = List.from(response.data);
    return AddressUserEstablishmentEntity.fromMap(list.first);
  }

  @override
  Future<AddressUserEstablishmentEntity?> get({required String userAddressId, required String establishmentAddressId}) async {
    final response = await client.get('/rest/v1/address_user_establishment?user_address_id=eq.$userAddressId&establishment_address_id=eq.$establishmentAddressId');
    final List list = List.from(response.data);
    if (list.isEmpty) return null;
    return AddressUserEstablishmentEntity.fromMap(list.first);
  }

  @override
  Future<void> delete({required String userAddressId, required String establishmentAddressId}) async {
    await client.delete('/rest/v1/address_user_establishment?user_address_id=eq.$userAddressId&establishment_address_id=eq.$establishmentAddressId');
  }

  @override
  Future<void> deleteAllByEstablishmentAddressId({required String establishmentAddressId}) async {
    await client.delete('/rest/v1/address_user_establishment?establishment_address_id=eq.$establishmentAddressId');
  }
}
