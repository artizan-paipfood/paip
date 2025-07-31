import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:manager/src/modules/pdv/aplication/stores/menu_pdv_store.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/toggle_button_category.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ListSelectorCategories extends StatelessWidget {
  const ListSelectorCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<MenuPdvStore>();
    return ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: SizedBox(
                height: 38,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: store.categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => ToggleButtonCategory(
                      category: store.categories[index],
                      onTap: () => store.selectCategory(store.categories[index]),
                    ),
                  ),
                )),
          );
        });
  }
}
