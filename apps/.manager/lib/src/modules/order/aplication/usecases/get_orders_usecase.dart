import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/stores/bills_store.dart';
import 'package:manager/src/core/stores/orders_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class GetOrdersUsecase {
  final IOrderRepository orderRepo;

  final IBillRepository billRepo;

  GetOrdersUsecase({
    required this.orderRepo,
    required this.billRepo,
  });

  Future<void> call() async {
    final List<OrderModel> orders = [];
    final initialDate = DateTime.now().subtract(12.hours).toUtc();
    final endDate = DateTime.now().add(12.hours).toUtc();
    final resultOrders = await orderRepo.getByEstablishmentId(establishmentProvider.value.id, initialDate: initialDate, finalDate: endDate);
    final resultShedules = await orderRepo.getScheduledByEstablishmentId(establishmentProvider.value.id, initialDate: initialDate.subtract(1.days), finalDate: endDate);
    final bills = await billRepo.getByEstablishmentIdWithInterval(establishmentId: establishmentProvider.value.id, initialDate: initialDate.subtract(1.days), endDate: endDate);
    orders.addAll([...resultOrders.where((o) => o.isAvailable), ...resultShedules.where((o) => o.isAvailable)]);

    OrdersStore.instance.setOrders(orders);
    BillsStore.instance.setBills(bills);
  }
}
