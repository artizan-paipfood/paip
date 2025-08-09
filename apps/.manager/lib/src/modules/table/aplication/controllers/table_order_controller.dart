import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/stores/orders_store.dart';
import 'package:manager/src/modules/order/aplication/usecases/load_orders_by_bill_usecase.dart';
import 'package:manager/src/modules/table/aplication/stores/table_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class TableOrderController {
  final TableStore tableStore;

  final UpdateQueusRepository updateQueusRepo;

  final LoadOrdersByBillUsecase loadOrdersByBillUsecase;

  TableOrderController({
    required this.tableStore,
    required this.updateQueusRepo,
    required this.loadOrdersByBillUsecase,
  });

  void discartTable(TableModel table) {
    tableStore.setSelectedTable(null);
  }

  List<OrderModel> getOrdersByTable(TableModel table) {
    if (table.billId == null) return [];
    final result = OrdersStore.instance.orders.where((order) => order.billId == table.billId).toList();
    return result;
  }

  Future<void> loadOrdersByTable(TableModel table) async {
    if (table.billId == null) return;
    final orders = OrdersStore.instance.getOrdersByBillId(table.billId!);
    if (orders.isEmpty && table.status == TableStatus.occupied) {
      await loadOrdersByBillUsecase.call(billId: table.billId!, establishmentId: establishmentProvider.value.id);
    }
  }
}
