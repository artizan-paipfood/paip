import 'package:paipfood_package/paipfood_package.dart';

class UpsertOrdersUsecase {
  final IOrderRepository orderRepo;
  final IUpdateQueusRepository updateQueusRepo;

  UpsertOrdersUsecase({
    required this.orderRepo,
    required this.updateQueusRepo,
  });

  Future<void> call({required List<OrderModel> orders}) async {
    final result = await orderRepo.upsert(orders: orders, auth: AuthNotifier.instance.auth);
    await updateQueusRepo.upsert(UpdateQueusModel.fromOrders(orders: result));
  }
}
