import 'package:paipfood_package/paipfood_package.dart';

class SetDriverToOrderUsecase {
  final IOrderRepository orderRepo;

  SetDriverToOrderUsecase({required this.orderRepo});
  Future<void> call({required OrderModel order, required DriverAndUserAdapter driver}) async {
    await Future.wait([
      orderRepo.upsert(orders: [order.copyWith(driverId: driver.driver.userId)], auth: AuthNotifier.instance.auth),
    ]);
  }
}
