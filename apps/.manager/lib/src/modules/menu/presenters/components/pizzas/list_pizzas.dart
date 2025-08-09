import 'package:flutter/material.dart';

import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:manager/src/modules/menu/presenters/components/pizzas/card_pizza.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ListPizzas extends StatefulWidget {
  final CategoryModel category;
  final MenuStore store;
  const ListPizzas({
    required this.category,
    required this.store,
    super.key,
  });

  @override
  State<ListPizzas> createState() => _ListPizzasState();
}

class _ListPizzasState extends State<ListPizzas> {
  late final ComplementModel complementPizza = widget.category.products.first.complements.firstWhere((element) => element.complementType == ComplementType.pizza);
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ReorderableListView.builder(
          onReorder: (oldIndex, newIndex) => widget.store.ordeningItens(oldIndex: oldIndex, newIndex: newIndex, complement: complementPizza),
          buildDefaultDragHandles: false,
          shrinkWrap: true,
          itemCount: complementPizza.itemsSortIndex.length,
          itemBuilder: (contextconst, index) {
            if (complementPizza.itemsSortIndex[index].isDeleted) {
              return SizedBox.shrink(key: Key('$index'));
            }
            return CardPizza(
              key: Key('$index'),
              index: index,
              category: widget.category,
              item: complementPizza.itemsSortIndex[index],
              complement: complementPizza,
            );
          });
    });
  }
}
