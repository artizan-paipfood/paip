import 'package:core/core.dart';

abstract interface class IDeliveryAreasPerMileRepository {
  Future<List<DeliveryAreaPerMileEntity>> getByEstablishmentId(String id);
  Future<void> upsert({required List<DeliveryAreaPerMileEntity> areas, required String authToken});
  Future<void> delete({required String authToken});
}

class DeliveryAreasPerMileRepository implements IDeliveryAreasPerMileRepository {
  final IClient http;
  DeliveryAreasPerMileRepository({required this.http});

  final String table = 'delivery_areas_per_mile';

  @override
  Future<List<DeliveryAreaPerMileEntity>> getByEstablishmentId(String establishmentId) async {
    final request = await http.get("/rest/v1/$table?establishment_id=eq.$establishmentId&select=*");
    final List list = request.data;
    return list.map((e) => DeliveryAreaPerMileEntity.fromMap(e)).toList();
  }

  @override
  Future<void> upsert({required List<DeliveryAreaPerMileEntity> areas, required String authToken}) async {
    await http.post(
      "/rest/v1/$table",
      headers: headerUpsert() //
        ..addAll({'Authorization': 'Bearer $authToken'}),
      data: areas.map((e) => e.toMap()).toList(),
    );
  }

  @override
  Future<void> delete({required String authToken}) async {
    await http.delete(
      "/rest/v1/$table?is_deleted=eq.true",
      headers: {'Authorization': 'Bearer $authToken'},
    );
  }
}
