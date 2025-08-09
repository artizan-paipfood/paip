import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/modules/menu/presenters/view_models/cart_product_viewmodel.dart';
import 'package:app/src/modules/menu/presenters/components/cart_product/price_widget.dart';
import 'package:app/src/modules/menu/presenters/components/cart_product/tag_button_qty_flavor_pizza.dart';
import 'package:paipfood_package/paipfood_package.dart';

class HeaderInfoCartProduct extends StatelessWidget {
  final ProductModel product;
  final CartProductViewmodel cartProductViewmodel;
  const HeaderInfoCartProduct({required this.product, required this.cartProductViewmodel, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name, style: context.textTheme.titleLarge),
            0.5.sizedBoxH,
            if (product.description.isNotEmpty) Text(product.description, style: context.textTheme.bodyMedium?.muted(context)),
            if (product.isPizza)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: product.getQtyFlavorsPizza.map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TagButtonQtyFlavorPizza(
                      isSelected: cartProductViewmodel.cartProdutVm?.qtyFlavorsPizza?.qty == e.qty,
                      label: e.qty == 1 ? context.i18n.sabor(e.qty) : context.i18n.saborPlural(e.qty),
                      onTap: () {
                        cartProductViewmodel.switchQtyFlavorPizza(e);
                      },
                    ),
                  );
                }).toList(),
              ),
            PSize.i.sizedBoxH,
            if (!product.isPizza) PriceWidget(price: product.price, priceFrom: product.priceFrom, promotionalPrice: product.promotionalPrice),
          ],
        ),
      ),
    );
  }
}
