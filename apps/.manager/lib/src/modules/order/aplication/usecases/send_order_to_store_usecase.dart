import 'package:core_flutter/core_flutter.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/stores/orders_store.dart';
import 'package:manager/src/modules/order/aplication/stores/order_store.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:window_manager/window_manager.dart';

class SendOrderToStoreUsecase {
  final OrderStore orderStore;

  final OrderRepository orderRepo;
  SendOrderToStoreUsecase({
    required this.orderStore,
    required this.orderRepo,
  });
  Future<void> call(Map map) async {
    if (isWindows) await windowManager.focus();
    final order = OrderModel.fromMap(map);
    if (order.isAvailable == false) return;
    OrdersStore.instance.setOrder(order);
    await orderStore.addOrderToList(order);
    final currentOrderNumber = establishmentProvider.value.currentOrderNumber;
    if ((order.orderNumber ?? 0) > currentOrderNumber) {
      establishmentProvider.value = establishmentProvider.value.copyWith(currentOrderNumber: order.orderNumber!);
    }
  }
}
