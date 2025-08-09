import 'package:core/core.dart';
import 'package:manager/src/modules/order/aplication/usecases/upsert_order_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CancelOrderUsecase {
  final ICustomFunctionsRepository custonFunctionsRepo;
  final UpsertOrderUsecase upsertOrderUsecase;

  CancelOrderUsecase({
    required this.custonFunctionsRepo,
    required this.upsertOrderUsecase,
  });

  Future<void> call({required OrderModel order, required EstablishmentModel establishment, required String message}) async {
    if (order.isPaid) {
      await custonFunctionsRepo.refoundPayment(paymentId: order.charge!.paymentId, value: order.getAmount, establishment: establishment);
      order = order.copyWith(charge: order.charge!.copyWith(status: ChargeStatus.refunded));
    }

    order = order.copyWith(
      status: OrderStatusEnum.canceled,
      canceledDate: DateTime.now(),
    );

    await upsertOrderUsecase.call(order: order);
  }
}
