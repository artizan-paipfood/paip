import 'package:manager/src/core/stores/orders_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class LoadOrdersByBillUsecase {
  final OrderRepository orderRepo;

  LoadOrdersByBillUsecase({
    required this.orderRepo,
  });
  Future<void> call({required String billId, required String establishmentId}) async {
    final orders = await orderRepo.getByBillId(billId: billId, establishmentId: establishmentId);
    OrdersStore.instance.setOrders(orders);
  }
}
