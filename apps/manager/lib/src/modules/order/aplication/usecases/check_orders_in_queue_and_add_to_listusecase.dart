import 'package:manager/src/modules/order/aplication/usecases/send_order_to_store_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CheckOrdersInQueueAndAddToStoreUsecase {
  final IOrderRepository orderRepo;
  final SendOrderToStoreUsecase sendOrderToStoreUsecase;

  CheckOrdersInQueueAndAddToStoreUsecase({required this.orderRepo, required this.sendOrderToStoreUsecase});

  Future<void> call({required String establishmentId, required int currentOrderNumber}) async {
    final orders = await orderRepo.getOrdersWithOrderNumberGreaterThan(establishmentId: establishmentId, date: DateTime.now().subtract(7.hours), orderNumber: currentOrderNumber);
    for (final order in orders) {
      await sendOrderToStoreUsecase.call(order.toMap());
    }
  }
}
