import 'package:flutter/material.dart';
import 'package:app/src/modules/menu/presenters/view_models/cart_product_viewmodel.dart';
import 'package:app/src/modules/menu/presenters/components/cart_product/item_row_widget.dart';
import 'package:app/src/modules/menu/presenters/components/cart_product/price_widget.dart';
import 'package:app/src/modules/menu/presenters/components/cart_product/sliver_complement.dart';

import 'package:paipfood_package/paipfood_package.dart';

class SliverListComplementsCartProduct extends StatefulWidget {
  final ComplementModel complement;
  final CartProductViewmodel cartProductViewmodel;
  const SliverListComplementsCartProduct({
    required this.complement,
    required this.cartProductViewmodel,
    super.key,
  });

  @override
  State<SliverListComplementsCartProduct> createState() => _SliverListComplementsCartProductState();
}

class _SliverListComplementsCartProductState extends State<SliverListComplementsCartProduct> {
  late final cartProductVm = widget.cartProductViewmodel.cartProdutVm!;
  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      pushPinnedChildren: true,
      children: [
        SliverPersistentHeader(pinned: true, delegate: SliverDelegateComplement(complement: widget.complement, cartProductViewmodel: widget.cartProductViewmodel, context: context)),
        ...widget.complement.itemsSortIndex.sorted((a, b) => a.index.compareTo(b.index)).map((item) {
          final int qty = widget.cartProductViewmodel.cartProdutVm!.getQtyByItem(item: item, complement: widget.complement);
          final SizeModel? sizePizza = item.getSizeByProduct(widget.cartProductViewmodel.cartProdutVm!.product);
          return Column(
            children: [
              ItemRowWidget(
                name: item.name,
                description: item.description,
                isDivider: widget.complement.itemsSortIndex.indexOf(item) == widget.complement.itemsSortIndex.length - 1,
                isMultiple: widget.complement.isMultiple,
                qty: qty,
                priceWidget: sizePizza != null
                    ? PriceWidget(textStyle: context.textTheme.titleSmall, price: sizePizza.price / cartProductVm.qtyFlavorsPizza!.qty, promotionalPrice: (sizePizza.promotionalPrice ?? 0) / cartProductVm.qtyFlavorsPizza!.qty)
                    : PriceWidget(textStyle: context.textTheme.titleSmall, price: item.price, promotionalPrice: item.promotionalPrice),
                onincremet: () {
                  setState(() {
                    widget.cartProductViewmodel.addIem(complement: widget.complement, item: item, qty: qty);
                  });
                },
                onDecrement: () {
                  setState(() {
                    widget.cartProductViewmodel.removeItem(complement: widget.complement, item: item);
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
