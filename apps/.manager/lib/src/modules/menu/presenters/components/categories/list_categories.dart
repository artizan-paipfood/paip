import 'package:flutter/material.dart';

import 'package:manager/src/core/components/inner_container.dart';
import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:manager/src/modules/menu/presenters/components/categories/card_categorie.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ListCategories extends StatefulWidget {
  const ListCategories({super.key});

  @override
  State<ListCategories> createState() => _ListCategoriesState();
}

class _ListCategoriesState extends State<ListCategories> {
  late final store = context.read<MenuStore>();
  @override
  Widget build(BuildContext context) {
    return CwInnerContainer(
      padding: EdgeInsets.zero,
      child: ReorderableListView.builder(
          onReorder: (oldIndex, newIndex) => store.ordeningCategories(oldIndex: oldIndex, newIndex: newIndex),
          scrollController: store.scrollControllerCategorias,
          itemCount: store.categories.length,
          buildDefaultDragHandles: false,
          itemBuilder: (context, index) {
            if (store.categories[index].isDeleted) return SizedBox.shrink(key: Key('$index'));

            return Padding(
              key: Key('$index'),
              padding: const EdgeInsets.only(top: 8) + const EdgeInsets.symmetric(horizontal: 8),
              child: CardCategorie(
                index: index,
                category: store.categories[index],
                isSelected: store.categorySelected == store.categories[index],
                onTap: () => store.setCategory(store.categories[index]),
              ),
            );
          }),
    );
  }
}
