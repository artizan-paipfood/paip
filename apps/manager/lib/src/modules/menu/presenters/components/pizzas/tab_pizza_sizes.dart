import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:manager/src/modules/menu/presenters/components/pizzas/card_product_size_pizza.dart';
import 'package:paipfood_package/paipfood_package.dart';

class TabPizzaSizes extends StatelessWidget {
  final CategoryModel category;
  const TabPizzaSizes({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    late final store = context.read<MenuStore>();
    return SingleChildScrollView(
      child: Padding(
        padding: PSize.iii.paddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.i18n.descPageTamnhosQuantidadePizza, style: context.textTheme.headlineMedium),
            PSize.ii.sizedBoxH,
            Text(context.i18n.tamanhos, style: context.textTheme.titleLarge?.copyWith(color: context.color.tertiaryColor)),
            ValueListenableBuilder(
              valueListenable: store.rebuildProdutcs,
              builder: (context, _, __) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: category.products.length,
                  itemBuilder: (context, index) {
                    if (category.products[index].isDeleted) return const SizedBox.shrink();
                    return CardProductSizePizza(product: category.products[index]);
                  },
                );
              },
            ),
            PSize.iii.sizedBoxH,
            Align(
              alignment: Alignment.centerRight,
              child: PButton(
                label: context.i18n.adicionarTamanho,
                onPressedFuture: () async {
                  store.insertProductPizza(category_: category);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
