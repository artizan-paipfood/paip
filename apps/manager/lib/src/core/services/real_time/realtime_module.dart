import 'dart:async';

import 'package:manager/src/core/services/real_time/add_bill_realtime_usecase.dart';
import 'package:manager/src/core/services/real_time/add_order_command_realtime_usecase.dart';
import 'package:manager/src/core/services/real_time/add_table_realtime_usecase.dart';
import 'package:manager/src/core/services/real_time/update_queus_realtime_service.dart';
import 'package:manager/src/modules/order/aplication/usecases/check_orders_in_queue_and_add_to_listusecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/periodic_establishment_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/send_order_to_store_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/update_orders_in_list_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class RealtimeModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.singleton(
          (i) => PeriodicEstablishmentUsecase(
            dataSource: i.get(),
            verifyEstablishmentIsOpenUsecase: i.get(),
            checkOrdersInQueueAndAddToStoreUsecase: i.get(),
            userPreferencesViewmodel: i.get(),
          ),
        ),
        Bind.factory((i) => UpdateOrdersInListUsecase(orderStore: i.get(), orderRepo: i.get())),
        Bind.factory((i) => SendOrderToStoreUsecase(orderStore: i.get(), orderRepo: i.get())),
        Bind.factory((i) => CheckOrdersInQueueAndAddToStoreUsecase(orderRepo: i.get(), sendOrderToStoreUsecase: i.get())),
        Bind.factory((i) => AddOrderCommandRealtimeUsecase(i.get())),
        Bind.factory((i) => AddTableRealtimeUsecase(i.get())),
        Bind.factory((i) => AddBillRealtimeUsecase()),
        Bind.singleton(
          (i) => UpdateQueusRealtimeService(
            dataSource: i.get(),
            sendOrderToStoreUsecase: i.get(),
            checkOrdersInQueueAndAddToStoreUsecase: i.get(),
            periodicEstablishmentUsecase: i.get(),
            updateOrderInListUsecase: i.get(),
            addOrderCommandRealtimeUsecase: i.get(),
            addTableRealtimeUsecase: i.get(),
            addBillRealtimeUsecase: i.get(),
          ),
        ),
      ];
}
