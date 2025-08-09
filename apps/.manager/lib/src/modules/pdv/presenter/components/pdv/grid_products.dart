import 'package:flutter/material.dart';
import 'package:manager/src/modules/pdv/aplication/stores/menu_pdv_store.dart';
import 'package:manager/src/modules/pdv/aplication/stores/order_pdv_store.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/card_product_grid.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/cart_product/end_drawer_cart_product.dart';
import 'package:paipfood_package/paipfood_package.dart';

class GridProducts extends StatelessWidget {
  const GridProducts({super.key});

  @override
  Widget build(BuildContext context) {
    late final menuPdvStore = context.read<MenuPdvStore>();
    late final orderPdvStore = context.read<OrderPdvStore>();
    return Expanded(
      child: ListenableBuilder(
        listenable: menuPdvStore,
        builder: (context, __) {
          return SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: menuPdvStore.productsGrid
                    .map((product) => SizedBox(
                          child: CardProductGrid(
                              product: product,
                              onTap: () {
                                if (product.quickAdd) {
                                  orderPdvStore.addProduct(product.buildCartProductDto());
                                  return;
                                }
                                showDialog(
                                  context: context,
                                  builder: (context) => EndDrawerProductToCart(
                                    product: product,
                                    onSave: (result) {
                                      orderPdvStore.addProduct(result);
                                    },
                                  ),
                                );
                              }),
                        ))
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
