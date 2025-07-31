import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DeliveryAreasRepository implements IDeliveryAreasRepository {
  final IClient http;
  DeliveryAreasRepository({required this.http});

  final String table = 'delivery_areas';

  @override
  Future<List<DeliveryAreaModel>> getByEstablishmentId(String establishmentId) async {
    final request = await http.get("/rest/v1/$table?establishment_id=eq.$establishmentId&select=*");
    final List list = request.data;
    return list.map<DeliveryAreaModel>((area) {
      return DeliveryAreaModel.fromMap(area);
    }).toList();
  }

  @override
  Future<List<DeliveryAreaModel>> upsert({required List<DeliveryAreaModel> areas, required AuthModel auth}) async {
    final request = await http.post(
      "/rest/v1/$table",
      headers: HttpUtils.headerUpsertAuth(auth),
      data: areas.map((e) => e.toMap()).toList(),
    );
    final List list = request.data;
    return list.map<DeliveryAreaModel>((area) {
      return DeliveryAreaModel.fromMap(area);
    }).toList();
  }

  @override
  Future<void> delete({required String id, required AuthModel auth, bool isDeleted = false}) async {
    String query = "id=eq.$id";
    if (isDeleted) query = HttpUtils.queryIsDeleted(isDeleted);
    await http.delete(
      "/rest/v1/$table?$query",
      headers: {"Authorization": "Bearer ${auth.accessToken}"},
    );
  }

  @override
  Future<List<DeliveryAreaModel>> getByCity(String city) async {
    final request = await http.get("/rest/v1/$table?city=eq.$city&select=*");
    final List list = request.data;
    return list.map<DeliveryAreaModel>((area) {
      return DeliveryAreaModel.fromMap(area);
    }).toList();
  }
}
