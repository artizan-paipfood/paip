import 'package:manager/src/core/datasources/data_source.dart';

import 'package:paipfood_package/paipfood_package.dart';

class UpsertOrderOrderCommandUsecase {
  final IOrderRepository orderRepo;
  final IUpdateQueusRepository updateQueusRepo;

  final IOrderCommandRepository orderCommandRepo;
  final IBillRepository billRepo;
  final DataSource dataSource;

  UpsertOrderOrderCommandUsecase({required this.orderRepo, required this.updateQueusRepo, required this.orderCommandRepo, required this.billRepo, required this.dataSource});

  Future<void> call({required OrderModel order, required OrderCommandModel orderCommand}) async {
    BillModel? bill;
    if (orderCommand.billId == null) {
      bill = BillModel(id: uuid, establishmentId: establishmentProvider.value.id, orderCommandNumber: orderCommand.number);
      orderCommand = orderCommand.copyWith(billId: bill.id);
      await billRepo.upsert(bills: [bill], auth: AuthNotifier.instance.auth);
      await orderCommandRepo.upsert(orderCommands: [orderCommand], auth: AuthNotifier.instance.auth);
      await updateQueusRepo.upsert(UpdateQueusModel.fromOrderCommand(orderCommand));
      await updateQueusRepo.upsert(UpdateQueusModel.fromBill(bill));
    }
    order = order.copyWith(billId: orderCommand.billId);
    final result = await orderRepo.upsert(orders: [order.copyWith(billId: orderCommand.billId)], auth: AuthNotifier.instance.auth);
    await updateQueusRepo.upsert(UpdateQueusModel.fromOrder(order: result.first));
  }
}
