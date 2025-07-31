import 'package:paipfood_package/paipfood_package.dart';

class OrdersStore {
  static OrdersStore? _instance;
  // Avoid self instance
  OrdersStore._();
  static OrdersStore get instance => _instance ??= OrdersStore._();

  final Map<String, OrderModel> _orders = {};

  List<OrderModel> get orders => _orders.values.toList();

  OrderModel? getOrderById(String id) => _orders[id];

  void setOrder(OrderModel order) => _orders[order.id] = order;

  void setOrders(List<OrderModel> orders) {
    for (var order in orders) {
      _orders[order.id] = order;
    }
  }

  List<OrderModel> getOrdersByBillId(String id) {
    return orders.where((order) => order.billId == id).toList();
  }
}
