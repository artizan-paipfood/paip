import 'dart:async';
import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/order/order/aplication/stores/order_status_store.dart';
import 'package:app/src/modules/order/order/aplication/usecases/order_usecase.dart';
import 'package:app/src/modules/menu/domain/usecases/upsert_order_usecase.dart';
import 'package:app/src/modules/order/order/presenters/pages/order_page.dart';
import 'package:app/src/modules/order/order/presenters/pages/payment_sucess_page.dart';
import 'package:app/src/modules/order/order/presenters/pages/waiting_payment_page.dart';
import 'package:paipfood_package/paipfood_package.dart';

class OrderModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.factory((i) => OrderRepository(http: i.get())),
        Bind.factory((i) => UpdateQueusRepository(http: i.get())),
        Bind.factory((i) => UpsertOrderUsecase(orderRepo: i.get(), updateQueusRepo: i.get())),
        Bind.factory((i) => CustomFunctionsRepository(http: ClientDio(baseOptions: HttpUtils.customFunctionsBaseOptions))),
        Bind.factory((i) => MercadoPagoRepository(http: ClientDio(baseOptions: HttpUtils.mercadoPago))),
        Bind.factory((i) => OrderUsecase(establishmentRepo: i.get(), orderRepo: i.get(), addressRepo: i.get())),
        Bind.singleton((i) => OrderStatusStore(orderUsecase: i.get(), updateOrderUsecase: i.get())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Routes.orderRelative, child: (context, state) => OrderPage(orderId: state.pathParameters[Routes.orderIdParam]!)),
        // ChildRoute(
        //   Routes.claim.childR,
        //   name: Routes.claim.name,
        //   child: (context, state) => ClaimPage(orderId: state.pathParameters[Params.orderId]!),
        // ),
        ChildRoute(Routes.paymentSucessRelative, child: (context, state) => PaymentSucessPage(orderId: state.pathParameters[Routes.orderIdParam]!)),
        // ChildRoute(
        //   Routes.paymentCanceled.childR,
        //   name: Routes.paymentCanceled.name,
        //   child: (context, state) => const PaymentCanceledPage(),
        // ),
        ChildRoute(Routes.waitingPaymentRelative, child: (context, state) => WaitingPaymentPage(orderId: state.pathParameters[Routes.orderIdParam]!)),
      ];
}
