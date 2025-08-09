import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/dialog_end_drawer.dart';
import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:manager/src/modules/menu/presenters/components/pizzas/tab_bar_pizza.dart';
import 'package:paipfood_package/paipfood_package.dart';

class EndDrawerPizzaTab extends StatefulWidget {
  final CategoryModel category;
  const EndDrawerPizzaTab({required this.category, super.key});

  @override
  State<EndDrawerPizzaTab> createState() => _EndDrawerPizzaTabState();
}

class _EndDrawerPizzaTabState extends State<EndDrawerPizzaTab> {
  late final store = context.read<MenuStore>();
  final _isValid = ValueNotifier(false);
  late CategoryModel newCategory = widget.category.clone();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return CwDialogEndDrawer(
      child: Column(
        children: [
          Expanded(
            child: Form(
              key: formKey,
              child: TabBarPizza(
                category: newCategory,
                isValid: (isValid) {
                  _isValid.value = isValid;
                },
              ),
            ),
          ),
          Material(
            color: context.color.primaryBG,
            elevation: 2,
            child: Padding(
              padding: PSize.i.paddingAll,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CwTextButton(label: context.i18n.cancelar, onPressed: () => Navigator.of(context).pop()),
                  PSize.i.sizedBoxW,
                  ValueListenableBuilder(
                    valueListenable: _isValid,
                    builder: (context, isValid, _) {
                      return PButton(
                        label: context.i18n.salvar,
                        onPressedFuture: () async {
                          if (formKey.currentState!.validate()) {
                            final nav = Navigator.of(context);
                            await store.saveCategoryPizza(newCategory);
                            nav.pop();
                          }
                        },
                        // enable: isValid,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
