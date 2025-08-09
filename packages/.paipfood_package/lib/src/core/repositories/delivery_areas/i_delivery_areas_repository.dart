import 'package:paipfood_package/paipfood_package.dart';

abstract interface class IDeliveryAreasRepository {
  Future<List<DeliveryAreaModel>> getByEstablishmentId(String id);
  Future<List<DeliveryAreaModel>> getByCity(String city);
  Future<List<DeliveryAreaModel>> upsert({required List<DeliveryAreaModel> areas, required AuthModel auth});
  Future<void> delete({required String id, required AuthModel auth, bool isDeleted});
}
