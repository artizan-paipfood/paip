import 'package:flutter/material.dart';
import 'package:manager/src/modules/menu/presenters/components/price_widget.dart';
import 'package:manager/src/modules/pdv/aplication/stores/cart_product_store.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/cart_product/item_row_widget.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/cart_product/sliver_size.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SliverListSizesCartProduct extends StatefulWidget {
  final ProductModel product;
  final CartProductStore store;
  const SliverListSizesCartProduct({
    required this.product,
    required this.store,
    super.key,
  });

  @override
  State<SliverListSizesCartProduct> createState() => _SliverListSizesCartProductState();
}

class _SliverListSizesCartProductState extends State<SliverListSizesCartProduct> {
  late final cartProductVm = widget.store.cartProdutVm!;
  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      pushPinnedChildren: true,
      children: [
        SliverPersistentHeader(pinned: true, delegate: SliverDelegateSize(store: widget.store, context: context)),
        ...widget.product.sizes.map((size) {
          return Column(
            children: [
              ItemRowWidget(
                name: size.name,
                description: size.description,
                isDivider: widget.product.sizes.indexOf(size) == widget.product.sizes.length - 1,
                qty: cartProductVm.size!.id == size.id ? 1 : 0,
                priceWidget: PriceWidget(textStyle: context.textTheme.labelSmall, price: size.price, promotionalPrice: size.promotionalPrice),
                onincremet: () {
                  setState(() {
                    widget.store.switchSize(size);
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
