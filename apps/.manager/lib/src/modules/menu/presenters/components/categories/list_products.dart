import 'package:flutter/material.dart';

import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:manager/src/modules/menu/presenters/components/categories/card_product.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ListProducts extends StatefulWidget {
  final CategoryModel category;
  final MenuStore store;
  const ListProducts({
    required this.category,
    required this.store,
    super.key,
  });

  @override
  State<ListProducts> createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  void _orderIndexProduct(int oldIndex, int newIndex) {
    setState(() {
      widget.store.ordeningProducts(oldIndex: oldIndex, newIndex: newIndex, category: widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      onReorder: (oldIndex, newIndex) {
        _orderIndexProduct(oldIndex, newIndex);
      },
      shrinkWrap: true,
      itemCount: widget.category.products.length,
      buildDefaultDragHandles: false,
      itemBuilder: (contextconst, index) => CardProduct(
        key: Key('$index'),
        index: index,
        product: widget.category.products[index],
        category: widget.category,
      ),
    );
  }
}
