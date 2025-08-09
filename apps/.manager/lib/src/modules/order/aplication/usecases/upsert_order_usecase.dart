import 'package:paipfood_package/paipfood_package.dart';

class UpsertOrderUsecase {
  final IOrderRepository orderRepo;
  final IUpdateQueusRepository updateQueusRepo;

  UpsertOrderUsecase({
    required this.orderRepo,
    required this.updateQueusRepo,
  });

  Future<void> call({required OrderModel order}) async {
    final result = await orderRepo.upsert(orders: [order], auth: AuthNotifier.instance.auth);
    await updateQueusRepo.upsert(UpdateQueusModel.fromOrder(order: result.first.copyWith(charge: order.charge)));
  }
}
