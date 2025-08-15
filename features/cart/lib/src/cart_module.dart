import 'dart:async';
import 'package:cart/src/presentation/pages/cart_product_page.dart';
import 'package:cart/src/utils/routes.dart';
import 'package:core_flutter/core_flutter.dart';

class CartModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Routes.cartProductRelative,
          name: Routes.cartProductNamed,
          child: (context, state) => CartProductPage(productId: state.pathParameters['product_id']!),
        ),
      ];
}
