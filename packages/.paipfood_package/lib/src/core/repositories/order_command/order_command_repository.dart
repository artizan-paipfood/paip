import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class OrderCommandRepository implements IOrderCommandRepository {
  final IClient http;
  OrderCommandRepository({required this.http});
  final table = 'order_commands';
  @override
  Future<List<OrderCommandModel>> getByEstablishmentId(String establishmentId) async {
    final request = await http.get("/rest/v1/$table?establishment_id=eq.$establishmentId&select=*");
    final List list = request.data;
    return list.map<OrderCommandModel>((product) {
      return OrderCommandModel.fromMap(product);
    }).toList();
  }

  @override
  Future<List<OrderCommandModel>> upsert({required List<OrderCommandModel> orderCommands, required AuthModel auth}) async {
    final request = await http.post(
      "/rest/v1/$table",
      headers: HttpUtils.headerUpsertAuth(auth),
      data: orderCommands.map((e) => e.toMap()).toList(),
    );
    final List list = request.data;
    return list.map<OrderCommandModel>((product) {
      return OrderCommandModel.fromMap(product);
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
