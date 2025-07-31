import 'package:paipfood_package/paipfood_package.dart';

class UpdateOrderUsecase {
  final IOrderRepository orderRepo;
  final IUpdateQueusRepository updateQueusRepo;

  UpdateOrderUsecase({
    required this.orderRepo,
    required this.updateQueusRepo,
  });

  Future<void> call({required OrderModel order}) async {
    final result = await orderRepo.upsert(orders: [order], auth: AuthNotifier.instance.auth);
    await updateQueusRepo.upsert(UpdateQueusModel.fromOrderReactivity(order: result.first));
  }
}
