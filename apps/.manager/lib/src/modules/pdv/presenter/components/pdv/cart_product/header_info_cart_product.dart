import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/menu/presenters/components/price_widget.dart';
import 'package:manager/src/modules/pdv/aplication/stores/cart_product_store.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/cart_product/tag_button_qty_flavor_pizza.dart';
import 'package:paipfood_package/paipfood_package.dart';

class HeaderInfoCartProduct extends StatelessWidget {
  final ProductModel product;
  final CartProductStore store;
  final Color colorText;
  const HeaderInfoCartProduct({required this.product, required this.store, required this.colorText, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name, style: context.textTheme.titleLarge?.copyWith(color: colorText)),
            0.5.sizedBoxH,
            if (product.description.isNotEmpty) Text(product.description, style: context.textTheme.labelSmall?.copyWith(color: colorText)),
            if (product.isPizza)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: product.getQtyFlavorsPizza.map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TagButtonQtyFlavorPizza(
                      isSelected: store.cartProdutVm?.qtyFlavorsPizza?.qty == e.qty,
                      colorSelected: context.color.primaryColor,
                      label: e.qty == 1 ? context.i18n.sabor(e.qty) : context.i18n.saborPlural(e.qty),
                      onTap: () {
                        store.switchQtyFlavorPizza(e);
                      },
                    ),
                  );
                }).toList(),
              ),
            PSize.i.sizedBoxH,
            if (!product.isPizza) PriceWidget(price: product.price, priceFrom: product.priceFrom, promotionalPrice: product.promotionalPrice, colorText: Colors.white),
          ],
        ),
      ),
    );
  }
}
