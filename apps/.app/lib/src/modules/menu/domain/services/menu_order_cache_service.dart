import 'package:paipfood_package/paipfood_package.dart';

class MenuOrderCacheService {
  final ILocalStorage localStorage;
  MenuOrderCacheService({
    required this.localStorage,
  });

  DateTime? cacheTimer;
  bool get needUpdate => DateTime.now().isAfter(cacheTimer ?? DateTime.now());

  Future<OrderModel?> getOrder(String establishmentId) async {
    final result = await localStorage.get(OrderModel.box, key: OrderModel.box);
    if (result == null) return null;
    final order = OrderModel.fromMap(result);
    if (order.establishmentId != establishmentId) {
      clearOrder();
      return null;
    }
    final now = DateTime.now();
    final orderDate = order.createdAt!.pNormalizeToCondition();
    if (now.isAfter(orderDate.add(10.minutes))) {
      clearOrder();
      return null;
    }
    return order;
  }

  void clearOrder() {
    localStorage.delete(OrderModel.box, keys: [OrderModel.box]);
  }

  Future<void> saveOrder(OrderModel order) async {
    await localStorage.put(OrderModel.box, key: OrderModel.box, value: order.toMap());
  }
}
