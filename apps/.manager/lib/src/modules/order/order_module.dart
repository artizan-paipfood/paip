import 'dart:async';
import 'package:manager/src/core/helpers/routes.dart';
import 'package:manager/src/modules/order/presenter/orders_page.dart';
import 'package:manager/src/modules/pdv/aplication/stores/cart_product_store.dart';
import 'package:manager/src/modules/pdv/pdv_core_module.dart';
import 'package:manager/src/modules/table/table_module.dart';
import 'package:paipfood_package/paipfood_package.dart';

class OrderModule extends Module {
  @override
  FutureOr<List<Module>> imports() => [TableModule(), PdvCoreModule()];
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.factory((i) => CartProductStore()),
      ];

  @override
  List<ModularRoute> get routes => [ChildRoute(Routes.ordersRelative, child: (context, args) => const OrdersPage())];
}
