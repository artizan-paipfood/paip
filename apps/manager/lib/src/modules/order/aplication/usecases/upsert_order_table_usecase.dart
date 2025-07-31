import 'package:manager/src/core/datasources/data_source.dart';
import 'package:paipfood_package/paipfood_package.dart';

class UpsertOrderTableUsecase {
  final IOrderRepository orderRepo;
  final IUpdateQueusRepository updateQueusRepo;
  final ITableRepository tableRepo;
  final IBillRepository billRepo;
  final DataSource dataSource;

  UpsertOrderTableUsecase({required this.orderRepo, required this.updateQueusRepo, required this.tableRepo, required this.billRepo, required this.dataSource});

  Future<void> call({required OrderModel order, required TableModel table}) async {
    BillModel? bill;
    if (table.billId == null) {
      bill = BillModel(id: uuid, establishmentId: establishmentProvider.value.id, tableNumber: table.buildTableNumber(), orderCommandNumber: table.orderCommandNumber);
      table = table.copyWith(billId: bill.id);
      await billRepo.upsert(bills: [bill], auth: AuthNotifier.instance.auth);
      await tableRepo.upsert(tables: [table], auth: AuthNotifier.instance.auth);
      await updateQueusRepo.upsert(UpdateQueusModel.fromTable(table));
      await updateQueusRepo.upsert(UpdateQueusModel.fromBill(bill));
    }
    order = order.copyWith(billId: table.billId);
    final result = await orderRepo.upsert(orders: [order.copyWith(billId: table.billId)], auth: AuthNotifier.instance.auth);
    await updateQueusRepo.upsert(UpdateQueusModel.fromOrder(order: result.first));
  }
}
