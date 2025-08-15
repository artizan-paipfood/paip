import 'dart:async';
import 'package:cart/src/domain/usecases/add_item_to_cart_product.dart';
import 'package:cart/src/domain/usecases/remove_item_from_cart_product.dart';
import 'package:cart/src/domain/usecases/validate_cart_product.dart';
import 'package:cart/src/presentation/pages/cart_product_page.dart';
import 'package:cart/src/presentation/viewmodels/cart_product_viewmodel.dart';
import 'package:cart/src/utils/routes.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';

class CartModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.singleton((i) => ViewsApi(client: i.get())),
        Bind.singleton((i) => AddItemToCartProduct()),
        Bind.singleton((i) => RemoveItemFromCartProduct()),
        Bind.singleton((i) => ValidateCartProduct()),
        Bind.singleton(
          (i) => CartProductViewmodel(
            viewsApi: i.get(),
            addItemToCartProduct: i.get(),
            removeItemFromCartProduct: i.get(),
            validateCartProduct: i.get(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Routes.cartProductRelative,
          name: Routes.cartProductNamed,
          child: (context, state) => CartProductPage(productId: state.pathParameters['product_id']!),
        ),
      ];
}
