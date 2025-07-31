import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class OrderRepository implements IOrderRepository {
  final IClient http;
  OrderRepository({required this.http});
  final table = 'orders';
  final view = 'view_orders';
  // final viewInvoices = 'orders_with_invoice';
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
  Future<OrderModel> get(String id) async {
    final request = await http.get("/rest/v1/$view?id=eq.$id&select=*");
    final List list = request.data;
    return list
        .map<OrderModel>((order) {
          return OrderModel.fromMap(order);
        })
        .toList()
        .first;
  }

  @override
  Future<List<OrderModel>> getByEstablishmentId(String id, {DateTime? initialDate, DateTime? finalDate}) async {
    initialDate ??= DateTime.now().subtract(1.days);
    finalDate ??= DateTime.now().add(1.days);
    final request = await http.get("/rest/v1/$view?establishment_id=eq.$id&created_at=gt.$initialDate&created_at=lt.$finalDate&select=*");
    final List list = request.data;
    return list.map<OrderModel>((order) {
      return OrderModel.fromMap(order);
    }).toList();
  }

  @override
  Future<List<OrderModel>> getByEstablishmentIdInIds({required String establishmentId, required List<String> orderIds}) async {
    final request = await http.get("/rest/v1/$view?establishment_id=eq.$establishmentId&id=in.(${orderIds.join(",")})&select=*");
    final List list = request.data;
    return list.map<OrderModel>((order) {
      return OrderModel.fromMap(order);
    }).toList();
  }

  @override
  Future<List<OrderModel>> getScheduledByEstablishmentId(String id, {DateTime? initialDate, DateTime? finalDate}) async {
    initialDate ??= DateTime.now().subtract(1.days);
    finalDate ??= DateTime.now().add(1.days);
    final request = await http.post("/rest/v1/rpc/func_get_orders_scheduled_by_establishment_id", data: {
      "p_establishment_id": id,
      "p_end_date": finalDate.pToTimesTamptzFormat(),
      "p_initial_date": initialDate.pToTimesTamptzFormat(),
    });
    final List list = request.data;
    return list.map<OrderModel>((order) {
      return OrderModel.fromMap(order);
    }).toList();
  }

  @override
  Future<List<OrderModel>> getByUserId(String userId, {DateTime? initialDate, DateTime? finalDate}) async {
    initialDate ??= DateTime.now().subtract(1.days);
    finalDate ??= DateTime.now().add(1.days);
    final request = await http.get("/rest/v1/$view?user_id=eq.$userId&created_at=gt.$initialDate&created_at=lt.$finalDate&select=*");
    final List list = request.data;
    return list.map<OrderModel>((order) {
      return OrderModel.fromMap(order);
    }).toList();
  }

  @override
  Future<List<OrderModel>> getByUserIdAndEstablishmentId(String userId, String establishmentId, {DateTime? initialDate, DateTime? finalDate}) async {
    initialDate ??= DateTime.now().subtract(1.days);
    finalDate ??= DateTime.now().add(1.days);
    final request = await http.get("/rest/v1/$view?user_id=eq.$userId&establishment_id=eq.$establishmentId&created_at=gt.$initialDate&created_at=lt.$finalDate&select=*");
    final List list = request.data;
    return list.map<OrderModel>((order) {
      return OrderModel.fromMap(order);
    }).toList();
  }

  @override
  Future<List<OrderModel>> upsert({required List<OrderModel> orders, required AuthModel auth}) async {
    final request = await http.post(
      "/rest/v1/$table",
      headers: HttpUtils.headerUpsertAuth(auth),
      data: orders.map((e) => e.toMap()).toList(),
    );
    final List list = request.data;
    return list.map<OrderModel>((order) {
      return OrderModel.fromMap(order);
    }).toList();
  }

  @override
  Future<Map<String, dynamic>> getResumeOrderById({required String id, required List<String> columns}) async {
    if (columns.isEmpty) throw "Parametro columns não pode ser vazio";
    final request = await http.get("/rest/v1/$view?id=eq.$id&select=${columns.join(",")}");
    final List list = request.data;
    return list.first;
  }

  @override
  Future<List<OrderModel>> getByDriverId({required String driver, DateTime? initialDate, DateTime? finalDate}) async {
    initialDate ??= DateTime.now().subtract(1.days);
    finalDate ??= DateTime.now().add(1.days);
    final request = await http.get("/rest/v1/$view?delivery_man_id=eq.$driver&created_at=gt.$initialDate&created_at=lt.$finalDate&order_type=eq.delivery&select=*");
    final List list = request.data;
    return list.map<OrderModel>((order) {
      return OrderModel.fromMap(order);
    }).toList();
  }

  @override
  Future<List<OrderModel>> getOrdersWithOrderNumberGreaterThan({required String establishmentId, required DateTime date, required int orderNumber}) async {
    final request = await http.post(
      "/rest/v1/rpc/func_get_orders_with_order_number_greater_than",
      data: {
        "p_establishment_id": establishmentId,
        "p_date": date.pToTimesTamptzFormat(),
        "p_order_number": orderNumber,
      },
    );
    final List list = request.data;
    return list.map<OrderModel>((order) {
      return OrderModel.fromMap(order);
    }).toList();
  }

  @override
  Future<List<OrderModel>> getByBillId({required String billId, required String establishmentId}) async {
    final request = await http.get("/rest/v1/$view?bill_id=eq.$billId&establishment_id=eq.$establishmentId&select=*");
    final List list = request.data;
    return list.map<OrderModel>((order) {
      return OrderModel.fromMap(order);
    }).toList();
  }
}
