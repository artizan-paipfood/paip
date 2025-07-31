import 'package:paipfood_package/paipfood_package.dart';

abstract interface class IOrderRepository {
  Future<OrderModel> get(String id);
  Future<List<OrderModel>> getByEstablishmentId(String id, {DateTime? initialDate, DateTime? finalDate});
  Future<List<OrderModel>> getByEstablishmentIdInIds({required String establishmentId, required List<String> orderIds});
  Future<List<OrderModel>> getScheduledByEstablishmentId(String id, {DateTime? initialDate, DateTime? finalDate});
  Future<List<OrderModel>> getByUserId(String userId, {DateTime? initialDate, DateTime? finalDate});
  Future<List<OrderModel>> getByUserIdAndEstablishmentId(String userId, String establishmentId, {DateTime? initialDate, DateTime? finalDate});
  Future<List<OrderModel>> getByDriverId({required String driver, DateTime? initialDate, DateTime? finalDate});
  Future<List<OrderModel>> getByBillId({required String billId, required String establishmentId});
  Future<List<OrderModel>> upsert({required List<OrderModel> orders, required AuthModel auth});
  Future<void> delete({required String id, required AuthModel auth, bool isDeleted = false});
  Future<Map<String, dynamic>> getResumeOrderById({required String id, required List<String> columns});
  Future<List<OrderModel>> getOrdersWithOrderNumberGreaterThan({required String establishmentId, required DateTime date, required int orderNumber});
}
