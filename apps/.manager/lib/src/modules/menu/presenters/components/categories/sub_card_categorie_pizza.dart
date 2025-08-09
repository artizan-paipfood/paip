import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/menu/presenters/components/pizzas/end_drawer_pizza_tab.dart';
import 'package:paipfood_package/paipfood_package.dart';

import '../../../../../core/components/divider.dart';

class SubCardCategoriePizza extends StatelessWidget {
  final CategoryModel category;
  const SubCardCategoriePizza({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CwDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(width: 30, height: 30, decoration: BoxDecoration(color: context.color.primaryColor, borderRadius: BorderRadius.circular(2)), child: const Icon(Icons.local_pizza_outlined, color: Colors.black)),
                const SizedBox(width: 5),
                Text(context.i18n.quantidadeSabores),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(width: 30, height: 30, decoration: BoxDecoration(border: Border.all(width: 2), color: context.color.primaryColor, borderRadius: BorderRadius.circular(100)), child: Center(child: Container(width: 2, color: Colors.black))),
                ),
                const SizedBox(width: 5),
                Text(context.i18n.bordas),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(width: 30, height: 30, decoration: BoxDecoration(border: Border.all(width: 2), color: context.color.primaryColor, borderRadius: BorderRadius.circular(100)), child: const Icon(Icons.eco_outlined, color: Colors.black)),
                ),
                const SizedBox(width: 5),
                Text(context.i18n.adicionais),
              ],
            ),
            IconButton(
              onPressed: () {
                showDialog(context: context, builder: (context) => EndDrawerPizzaTab(category: category.clone()));
              },
              icon: const Icon(PaipIcons.edit),
            ),
          ],
        ),
      ],
    );
  }
}
