import 'dart:async';
import 'package:manager/src/core/helpers/routes.dart';
import 'package:manager/src/core/logs/logs.dart';
import 'package:manager/src/core/services/printer/printer_service.dart';
import 'package:manager/src/core/services/real_time/realtime_module.dart';
import 'package:manager/src/core/services/update_service.dart';
import 'package:manager/src/core/usecases/build_local_customer_usecase.dart';
import 'package:manager/src/core/usecases/upsert_local_customer_usecase.dart';
import 'package:manager/src/modules/auth/auth_module.dart';
import 'package:manager/src/modules/chatbot/chatbot_module.dart';
import 'package:manager/src/modules/config/aplication/usecases/printer_usecase.dart';
import 'package:manager/src/modules/config/aplication/usecases/update_establishment_usecase.dart';
import 'package:manager/src/modules/config/config_module.dart';
import 'package:manager/src/modules/config/presenters/viewmodels/printer_viewmodel.dart';
import 'package:manager/src/modules/delivery/delivery_module.dart';
import 'package:manager/src/modules/driver/driver_module.dart';
import 'package:manager/src/modules/home/presenters/home/home_page.dart';
import 'package:manager/src/modules/invoices/invoice_module.dart';
import 'package:manager/src/modules/menu/menu_module.dart';
import 'package:manager/src/modules/order/aplication/stores/order_store.dart';
import 'package:manager/src/modules/order/aplication/usecases/cancel_order_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/get_orders_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/update_order_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/set_driver_to_order_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/upsert_order_usecase.dart';
import 'package:manager/src/modules/order/order_module.dart';
import 'package:manager/src/modules/pdv/pdv_module.dart';
import 'package:manager/src/modules/reports/reports_module.dart';
import 'package:paipfood_package/paipfood_package.dart';

class HomeModule extends Module {
  @override
  FutureOr<List<Module>> imports() => [
        RealtimeModule(),
        InvoiceModule(),
        ChatbotModule(),
      ];
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.factory((i) => HipayApi(client: ClientDio(baseOptions: HttpUtils.api()))),
        Bind.factory((i) => BuildLocalCustomerUsecase(localStorage: i.get())),
        Bind.factory((i) => UpsertLocalCustomerUsecase(localStorage: i.get(), dataSource: i.get(), buildCustomerUseCase: i.get())),
        Bind.singleton((i) => PrinterService.getInstance(localStorage: i.get())),
        Bind.factory((i) => PrinterUsecase(localStorage: i.get(), service: i.get(), client: ClientDio(baseOptions: BaseOptions(), talker: Logs.client.talker))),
        Bind.singleton((i) => PrinterViewmodel(printerUsecase: i.get())),
        Bind.singleton((i) => OrderRepository(http: i.get())),
        Bind.singleton((i) => UpdateService(http: i.get())),
        Bind.factory((i) => UpdateOrderUsecase(orderRepo: i.get(), updateQueusRepo: i.get())),
        Bind.factory((i) => BillRepository(http: i.get())),
        Bind.factory((i) => GetOrdersUsecase(orderRepo: i.get(), billRepo: i.get())),
        Bind.factory((i) => UpdateEstablishmentUsecase(establishmentRepo: i.get(), dataSource: i.get())),
        Bind.singleton((i) => CustomFunctionsRepository(http: ClientDio(baseOptions: HttpUtils.customFunctionsBaseOptions, talker: Logs.client.talker))),
        Bind.factory((i) => CancelOrderUsecase(custonFunctionsRepo: i.get(), upsertOrderUsecase: i.get())),
        Bind.factory((i) => UpsertOrderUsecase(orderRepo: i.get(), updateQueusRepo: i.get())),
        Bind.factory((i) => DriverRepository(http: i.get())),
        Bind.factory((i) => SetDriverToOrderUsecase(orderRepo: i.get())),
        Bind.singleton((i) => OrderStore(
            setDriverToOrderUsecase: i.get(),
            dataSource: i.get(),
            getOrdersUsecase: i.get(),
            orderRepo: i.get(),
            wppService: i.get(),
            cancelOrderUsecase: i.get(),
            printerViewmodel: i.get(),
            updateEstablishmentUsecase: i.get(),
            upsertLocalCustomerUsecase: i.get(),
            updateOrderUsecase: i.get(),
            userPreferencesViewmodel: i.get())),
      ];

  @override
  List<ModularRoute> get routes => [
        ShellModularRoute(builder: (context, state, child) => HomePage(child: child), routes: [
          ModuleRoute(
            Routes.configModule,
            module: ConfigModule(),
          ),
          ModuleRoute(
            Routes.deliveryAreasModule,
            module: DeliveryModule(),
          ),
          ModuleRoute(
            Routes.menuModule,
            module: MenuModule(),
          ),
          ModuleRoute(
            Routes.robotsModule,
            module: ChatbotModule(),
          ),
          ModuleRoute(
            Routes.pdvModule,
            module: PdvModule(),
          ),
          ModuleRoute(
            Routes.ordersModule,
            module: OrderModule(),
          ),
          ModuleRoute(
            Routes.driversModule,
            module: DriverModule(),
          ),
          ModuleRoute(
            Routes.reportsModule,
            module: ReportsModule(),
          ),
        ]),
        ModuleRoute(Routes.authModule, module: AuthModule()),
      ];
}
