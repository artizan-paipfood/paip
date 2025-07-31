import 'package:flutter/material.dart';
import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:manager/src/modules/menu/presenters/components/complements/card_item.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ListItems extends StatefulWidget {
  final ComplementModel complement;
  final MenuStore store;
  const ListItems({required this.complement, required this.store, super.key});

  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ReorderableListView.builder(
        onReorder: (oldIndex, newIndex) => widget.store.ordeningItens(oldIndex: oldIndex, newIndex: newIndex, complement: widget.complement),
        buildDefaultDragHandles: false,
        shrinkWrap: true,
        itemCount: widget.complement.itemsSortIndex.where((item) => !item.isDeleted).length,
        itemBuilder: (contextconst, index) => CardItem(
          key: Key('$index'),
          index: index,
          item: widget.complement.items[index],
          complement: widget.complement,
        ),
      );
    });
  }
}
