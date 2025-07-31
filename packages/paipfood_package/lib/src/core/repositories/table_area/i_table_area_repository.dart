import 'package:paipfood_package/paipfood_package.dart';

abstract interface class ITableAreaRepository {
  Future<List<TableAreaModel>> getByEstablishmentId(String id);
  Future<List<TableAreaModel>> upsert({required List<TableAreaModel> tableAreas, required AuthModel auth});
  Future<void> delete({required String id, required AuthModel auth, bool isDeleted});
}
