import 'package:flutter/material.dart';
import 'package:manager/src/modules/menu/presenters/components/price_widget.dart';
import 'package:manager/src/modules/pdv/aplication/stores/cart_product_store.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/cart_product/item_row_widget.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/cart_product/sliver_complement.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SliverWrapComplementsCartProduct extends StatefulWidget {
  final ComplementModel complement;
  final CartProductStore store;
  const SliverWrapComplementsCartProduct({
    required this.complement,
    required this.store,
    super.key,
  });

  @override
  State<SliverWrapComplementsCartProduct> createState() => _SliverWrapComplementsCartProductState();
}

class _SliverWrapComplementsCartProductState extends State<SliverWrapComplementsCartProduct> {
  late final cartProductVm = widget.store.cartProdutVm!;
  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      pushPinnedChildren: true,
      children: [
        SliverPersistentHeader(pinned: true, delegate: SliverDelegateComplement(complement: widget.complement, store: widget.store, context: context)),
        Padding(
          padding: PSize.i.paddingAll,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...widget.complement.itemsSortAZ.map((item) {
                final int qty = widget.store.cartProdutVm!.getQtyByItem(item: item, complement: widget.complement);
                final SizeModel? sizePizza = item.getSizeByProduct(widget.store.cartProdutVm!.product);
                return SizedBox(
                  width: 200,
                  child: ItemRowWidget(
                    name: item.name,
                    // description: item.description,
                    isDivider: widget.complement.itemsSortAZ.indexOf(item) == widget.complement.items.length - 1,
                    isMultiple: widget.complement.isMultiple,
                    qty: qty,
                    priceWidget: sizePizza != null
                        ? PriceWidget(textStyle: context.textTheme.labelLarge, price: sizePizza.price / cartProductVm.qtyFlavorsPizza!.qty, promotionalPrice: (sizePizza.promotionalPrice ?? 0) / cartProductVm.qtyFlavorsPizza!.qty)
                        : PriceWidget(textStyle: context.textTheme.labelSmall, price: item.price, promotionalPrice: item.promotionalPrice),
                    onincremet: () {
                      setState(() {
                        widget.store.addIem(complement: widget.complement, item: item, qty: qty);
                      });
                    },
                    onDecrement: () {
                      setState(() {
                        widget.store.removeItem(complement: widget.complement, item: item);
                      });
                    },
                  ),
                );
              }),
            ],
          ),
        )
      ],
    );
  }
}
