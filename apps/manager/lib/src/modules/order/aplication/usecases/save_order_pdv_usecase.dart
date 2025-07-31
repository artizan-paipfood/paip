import 'package:manager/src/modules/order/aplication/usecases/upsert_order_order_command_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/upsert_order_table_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/upsert_order_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SaveOrderPdvUsecase {
  UpsertOrderOrderCommandUsecase upsertOrderOrderCommandUsecase;
  UpsertOrderTableUsecase upsertOrderTableUsecase;
  UpsertOrderUsecase upsertOrderUsecase;
  SaveOrderPdvUsecase({
    required this.upsertOrderOrderCommandUsecase,
    required this.upsertOrderTableUsecase,
    required this.upsertOrderUsecase,
  });
  Future<void> call({required OrderModel order, TableModel? table, OrderCommandModel? orderCommand}) async {
    if (table != null) {
      await upsertOrderTableUsecase.call(order: order, table: table);
      return;
    }

    if (orderCommand != null) {
      await upsertOrderOrderCommandUsecase.call(order: order, orderCommand: orderCommand);
      return;
    }

    await upsertOrderUsecase.call(order: order);
  }
}
