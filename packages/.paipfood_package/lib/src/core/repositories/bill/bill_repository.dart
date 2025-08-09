import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class BillRepository implements IBillRepository {
  final IClient http;
  BillRepository({required this.http});
  final table = 'bills';
  @override
  Future<List<BillModel>> getByEstablishmentId(String establishmentId) async {
    final request = await http.get("/rest/v1/$table?establishment_id=eq.$establishmentId&select=*");
    final List list = request.data;
    return list.map<BillModel>((bill) {
      return BillModel.fromMap(bill);
    }).toList();
  }

  @override
  Future<BillModel> getById(String id) async {
    final request = await http.get("/rest/v1/$table?id=eq.$id&select=*");
    final List list = request.data;
    final bills = list.map<BillModel>((bill) {
      return BillModel.fromMap(bill);
    }).toList();

    return bills.first;
  }

  @override
  Future<List<BillModel>> upsert({required List<BillModel> bills, required AuthModel auth}) async {
    final request = await http.post(
      "/rest/v1/$table",
      headers: HttpUtils.headerUpsertAuth(auth),
      data: bills.map((e) => e.toMap()).toList(),
    );
    final List list = request.data;
    return list.map<BillModel>((bill) {
      return BillModel.fromMap(bill);
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
  Future<List<BillModel>> getByEstablishmentIdWithInterval({required String establishmentId, DateTime? initialDate, DateTime? endDate}) async {
    initialDate ??= DateTime.now().subtract(1.days);
    endDate ??= DateTime.now().add(1.days);
    final request = await http.get("/rest/v1/$table?establishment_id=eq.$establishmentId&created_at=gt.$initialDate&created_at=lt.$endDate&select=*");
    final List list = request.data;
    return list.map<BillModel>((order) {
      return BillModel.fromMap(order);
    }).toList();
  }
}
