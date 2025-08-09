import 'package:flutter/material.dart';
import 'package:app/src/modules/menu/presenters/view_models/cart_product_viewmodel.dart';
import 'package:app/src/modules/menu/presenters/components/cart_product/item_row_widget.dart';
import 'package:app/src/modules/menu/presenters/components/cart_product/price_widget.dart';
import 'package:app/src/modules/menu/presenters/components/cart_product/sliver_size.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SliverListSizesCartProduct extends StatefulWidget {
  final ProductModel product;
  final CartProductViewmodel cartProductViewmodel;
  const SliverListSizesCartProduct({
    required this.product,
    required this.cartProductViewmodel,
    super.key,
  });

  @override
  State<SliverListSizesCartProduct> createState() => _SliverListSizesCartProductState();
}

class _SliverListSizesCartProductState extends State<SliverListSizesCartProduct> {
  late final cartProductVm = widget.cartProductViewmodel.cartProdutVm!;
  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      pushPinnedChildren: true,
      children: [
        SliverPersistentHeader(pinned: true, delegate: SliverDelegateSize(cartProductViewmodel: widget.cartProductViewmodel, context: context)),
        ...widget.product.sizes.map((size) {
          return Column(
            children: [
              ItemRowWidget(
                name: size.name,
                description: size.description,
                isDivider: widget.product.sizes.indexOf(size) == widget.product.sizes.length - 1,
                qty: cartProductVm.size!.id == size.id ? 1 : 0,
                priceWidget: PriceWidget(textStyle: context.textTheme.titleSmall, price: size.price, promotionalPrice: size.promotionalPrice),
                onincremet: () {
                  setState(() {
                    widget.cartProductViewmodel.switchSize(size);
                  });
                },
              ),
            ],
          );
        }),
      ],
    );
  }
}
