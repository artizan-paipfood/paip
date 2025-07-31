import 'dart:developer';

import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/stores/orders_store.dart';
import 'package:manager/src/modules/order/aplication/stores/order_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class UpdateOrdersInListUsecase {
  final OrderStore orderStore;

  final OrderRepository orderRepo;
  UpdateOrdersInListUsecase({required this.orderStore, required this.orderRepo});

  Future<void> call(Map map) async {
    List<OrderModel> orders = [];
    if (map['ids'] != null) {
      final ids = List<String>.from(map['ids']);
      log(ids.runtimeType.toString());
      orders = await orderRepo.getByEstablishmentIdInIds(establishmentId: establishmentProvider.value.id, orderIds: ids);
    } else {
      final order = OrderModel.fromMap(map);
      orders.add(order);
    }

    final avaliables = orders.where((order) => order.isAvailable).toList();

    if (avaliables.isEmpty) return;
    OrdersStore.instance.setOrders(avaliables);

    for (var order in avaliables) {
      orderStore.updateOderInList(order);
    }
  }
}
