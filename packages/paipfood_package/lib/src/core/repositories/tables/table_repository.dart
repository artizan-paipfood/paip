import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class TableRepository implements ITableRepository {
  final IClient http;
  TableRepository({required this.http});
  final table = 'tables';
  @override
  Future<List<TableModel>> getByEstablishmentId(String establishmentId) async {
    final request = await http.get("/rest/v1/$table?establishment_id=eq.$establishmentId&select=*");
    final List list = request.data;
    return list.map<TableModel>((product) {
      return TableModel.fromMap(product);
    }).toList();
  }

  @override
  Future<List<TableModel>> upsert({required List<TableModel> tables, required AuthModel auth}) async {
    final request = await http.post(
      "/rest/v1/$table",
      headers: HttpUtils.headerUpsertAuth(auth),
      data: tables.map((e) => e.toMap()).toList(),
    );
    final List list = request.data;
    return list.map<TableModel>((product) {
      return TableModel.fromMap(product);
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
}
