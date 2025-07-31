import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:manager/src/modules/menu/presenters/components/pizzas/card_item_edit_pizza.dart';
import 'package:paipfood_package/paipfood_package.dart';

class TabPizzaBorderPasta extends StatefulWidget {
  final CategoryModel category;
  const TabPizzaBorderPasta({required this.category, super.key});

  @override
  State<TabPizzaBorderPasta> createState() => _TabPizzaBorderPastaState();
}

class _TabPizzaBorderPastaState extends State<TabPizzaBorderPasta> {
  late final store = context.read<MenuStore>();
  late final List<ComplementModel> complements = widget.category.products.first.complements.where((element) => element.complementType == ComplementType.optionalPizza).toList();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: PSize.iii.paddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.i18n.tituloBordasEMassas, style: context.textTheme.headlineMedium),
            PSize.ii.sizedBoxH,
            ListView.builder(
              shrinkWrap: true,
              itemCount: complements.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Align(alignment: Alignment.centerLeft, child: Text(complements[index].name, style: context.textTheme.titleLarge?.copyWith(color: context.color.tertiaryColor)).center),
                    ValueListenableBuilder(
                      valueListenable: store.rebuildItems,
                      builder: (context, _, __) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: complements[index].items.length,
                          itemBuilder: (context, idx) {
                            if (complements[index].items[idx].isDeleted) return const SizedBox.shrink();
                            return CardItemEditPizza(item: complements[index].items[idx]);
                          },
                        );
                      },
                    ),
                    PSize.iii.sizedBoxH,
                    Align(
                      alignment: Alignment.centerRight,
                      child: PButton(
                        label: context.i18n.adicionarItemA(complements[index].name),
                        onPressed: () {
                          store.insertItem(complements[index]);
                        },
                      ),
                    ),
                    PSize.ii.sizedBoxH,
                    const Divider(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
