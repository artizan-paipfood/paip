import 'dart:async';

import 'package:core/core.dart';
import 'package:manager/src/modules/menu/aplication/usecases/get_menu_local_usecase.dart';
import 'package:manager/src/modules/menu/aplication/usecases/get_menu_vm_usecase.dart';
import 'package:manager/src/modules/menu/aplication/usecases/rebase_menu_local_storage_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/load_orders_by_bill_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/save_order_pdv_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/upsert_bill_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/upsert_order_order_command_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/upsert_order_table_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/upsert_order_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/upsert_orders_usecase.dart';
import 'package:manager/src/modules/pdv/aplication/stores/address_customer_store.dart';
import 'package:manager/src/modules/pdv/aplication/stores/cart_product_store.dart';
import 'package:manager/src/modules/pdv/aplication/stores/customer_store.dart';
import 'package:manager/src/modules/pdv/aplication/stores/menu_pdv_store.dart';
import 'package:manager/src/modules/pdv/aplication/stores/order_pdv_store.dart';
import 'package:manager/src/modules/pdv/aplication/stores/payment/payment_bill_controller.dart';
import 'package:manager/src/modules/pdv/aplication/stores/payment/payment_order_controller.dart';
import 'package:manager/src/modules/pdv/aplication/usecases/get_bill_by_id_usecase.dart';
import 'package:manager/src/modules/table/aplication/controllers/table_order_controller.dart';
import 'package:manager/src/modules/table/aplication/stores/order_command_store.dart';
import 'package:manager/src/modules/table/aplication/stores/table_store.dart';
import 'package:manager/src/modules/table/aplication/usecases/link_table_usecase.dart';
import 'package:manager/src/modules/table/aplication/usecases/table_turn_avaliable_usecase.dart';
import 'package:manager/src/modules/table/aplication/usecases/table_turn_occupied_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PdvCoreModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.factory(
          (i) => UpsertOrderUsecase(
            orderRepo: i.get(),
            updateQueusRepo: i.get(),
          ),
        ),
        Bind.factory(
          (i) => SaveOrderPdvUsecase(
            upsertOrderOrderCommandUsecase: i.get(),
            upsertOrderTableUsecase: i.get(),
            upsertOrderUsecase: i.get(),
          ),
        ),
        Bind.factory((i) => EstablishmentRepository(http: i.get())),
        Bind.factory((i) => GetMenuHttpUsecase(establishmentRepo: i.get())),
        Bind.factory((i) => GetMenuLocalUsecase(localStorage: i.get())),
        Bind.factory((i) => AddressApi(client: ClientDio(baseOptions: HttpUtils.api()))),
        Bind.factory((i) => AddressCustomerStore(addressApi: i.get(), dataSource: i.get())),
        Bind.factory((i) => RebaseMenuLocalStorageUsecase(localStorage: i.get())),
        Bind.factory((i) => UpsertBillUsecase(billRepo: i.get(), updateQueusRepo: i.get())),
        Bind.factory((i) => TableTurnAvaliableUsecase(tableRepo: i.get(), updateQueusRepo: i.get())),
        Bind.factory((i) => TableTurnOccupiedUsecase(tableRepo: i.get(), updateQueusRepo: i.get())),
        Bind.singleton(
          (i) => PaymentBillController(
            dataSource: i.get(),
            upsertBillUsecase: i.get(),
            tableStore: i.get(),
            tableRepo: i.get(),
            updateQueusRepo: i.get(),
          ),
        ),
        Bind.singleton(
          (i) => PaymentOrderController(dataSource: i.get(), updateQueusRepo: i.get(), orderPdvStore: i.get()),
        ),
        Bind.factory(
          (i) => GetMenuVmUsecase(
            dataSource: i.get(),
            getMenuLocalUsecase: i.get(),
            getMenuHttpUsecase: i.get(),
            localStorage: i.get(),
            bucketRepo: i.get(),
            rebaseMenuLocalStorageUsecase: i.get(),
          ),
        ),
        Bind.singleton((i) => CustomerStore(localStorage: i.get())),
        Bind.factory((i) => CartProductStore()),
        Bind.factory((i) => GetBillByIdUsecase(billRepo: i.get())),
        Bind.singleton((i) => MenuPdvStore(getMenuVmUsecase: i.get(), dataSource: i.get())),
        Bind.singleton(
          (i) => OrderPdvStore(
            addressApi: i.get(),
            customerStore: i.get(),
            dataSource: i.get(),
            printerViewmodel: i.get(),
            orderStore: i.get(),
            saveOrderPdvUsecase: i.get(),
            tableStore: i.get(),
            getBillByIdUsecase: i.get(),
            localStorage: i.get(),
          ),
        ),
        Bind.factory((i) => LoadOrdersByBillUsecase(orderRepo: i.get())),
        Bind.factory((i) => UpsertOrdersUsecase(orderRepo: i.get(), updateQueusRepo: i.get())),
        Bind.factory((i) => LinkTableUsecase(dataSource: i.get(), upsertOrdersUsecase: i.get())),
        Bind.singleton(
          (i) => TableOrderController(
            tableStore: i.get(),
            updateQueusRepo: i.get(),
            loadOrdersByBillUsecase: i.get(),
          ),
        ),
        Bind.factory(
          (i) => UpsertOrderOrderCommandUsecase(
            orderRepo: i.get(),
            updateQueusRepo: i.get(),
            billRepo: i.get(),
            dataSource: i.get(),
            orderCommandRepo: i.get(),
          ),
        ),
        Bind.factory(
          (i) => UpsertOrderTableUsecase(
            orderRepo: i.get(),
            updateQueusRepo: i.get(),
            billRepo: i.get(),
            dataSource: i.get(),
            tableRepo: i.get(),
          ),
        ),
        Bind.factory((i) => BillRepository(http: i.get())),
        Bind.factory((i) => TableAreaRepository(http: i.get())),
        Bind.factory((i) => TableRepository(http: i.get())),
        Bind.factory((i) => OrderCommandRepository(http: i.get())),
        Bind.singleton((i) => OrderCommandStore(orderCommandRepo: i.get(), dataSource: i.get())),
        Bind.singleton(
          (i) => TableStore(tableAreaRepo: i.get(), tableRepo: i.get(), dataSource: i.get(), tableTurnAvaliableUsecase: i.get(), linkTableUsecase: i.get(), tableTurnOccupiedUsecase: i.get(), upsertBillUsecase: i.get()),
        ),
      ];
}
