import 'package:flutter/material.dart';

import 'package:manager/src/core/components/inner_container.dart';
import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:manager/src/modules/menu/presenters/components/complements/card_complement.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ListComplements extends StatelessWidget {
  const ListComplements({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<MenuStore>();
    return CwInnerContainer(
        padding: EdgeInsets.zero,
        child: ReorderableListView.builder(
            onReorder: (oldIndex, newIndex) => store.ordeningComplements(oldIndex: oldIndex, newIndex: newIndex),
            buildDefaultDragHandles: false,
            itemCount: store.complements.length,
            scrollController: store.scrollControllerComplements,
            itemBuilder: (context, index) {
              if (store.complements[index].isDeleted || store.complements[index].complementType != ComplementType.item) {
                return SizedBox.shrink(
                  key: Key('$index'),
                );
              }
              return Padding(
                key: Key('$index'),
                padding: const EdgeInsets.only(top: 8) + const EdgeInsets.symmetric(horizontal: 8),
                child: CardComplement(
                  index: index,
                  complement: store.complements[index],
                  isSelected: store.complementSelected == store.complements[index],
                  onTap: () {
                    store.setComplement(store.complements[index]);
                  },
                ),
              );
            }));
  }
}
