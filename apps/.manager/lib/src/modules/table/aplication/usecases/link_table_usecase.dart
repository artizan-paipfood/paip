import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/stores/orders_store.dart';
import 'package:manager/src/modules/order/aplication/usecases/upsert_orders_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class LinkTableUsecase {
  final DataSource dataSource;
  final UpsertOrdersUsecase upsertOrdersUsecase;

  LinkTableUsecase({
    required this.dataSource,
    required this.upsertOrdersUsecase,
  });

  Future<List<TableModel>> call({required List<TableModel> tables}) async {
    final tableParent = tables.firstWhereOrNull((table) => dataSource.isTableParent(table.number));
    TableModel? tableChild;
    if (tableParent != null) {
      tableChild = tables.firstWhere((table) => table.number != tableParent.number);
      tableChild = tableChild.copyWith(tableParentNumber: tableParent.number, status: tableParent.status);
    } else {
      tableChild = tables[0].copyWith(tableParentNumber: tables[1].number, status: tables[1].status);
    }

    if (tableChild.billId != null) {
      final orders = OrdersStore.instance.getOrdersByBillId(tableChild.billId!);
      tableChild.billId = null;

      if (orders.isNotEmpty) {
        await upsertOrdersUsecase.call(orders: orders);
      }
    }
    final result = buildResutlTables(tableChild: tableChild, tables: tables);

    dataSource.setTables(result);

    return result;
  }
}

List<TableModel> buildResutlTables({required TableModel tableChild, required List<TableModel> tables}) {
  final List<TableModel> result = [tableChild];
  for (final table in tables) {
    if (table.number != tableChild.number) {
      result.add(table);
    }
  }
  return result;
}
