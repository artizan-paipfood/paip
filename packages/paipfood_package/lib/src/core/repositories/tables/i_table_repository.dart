import 'package:paipfood_package/paipfood_package.dart';

abstract interface class ITableRepository {
  Future<List<TableModel>> getByEstablishmentId(String id);
  Future<List<TableModel>> upsert({required List<TableModel> tables, required AuthModel auth});
  Future<void> delete({required String id, required AuthModel auth, bool isDeleted});
}
