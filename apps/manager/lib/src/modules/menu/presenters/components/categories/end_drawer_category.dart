import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/helpers/assets.dart';
import 'package:manager/src/core/components/dialog_end_drawer.dart';
import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:manager/src/modules/menu/presenters/components/pizzas/card_select_category_type.dart';
import 'package:manager/src/modules/menu/presenters/components/pizzas/end_drawer_pizza_tab.dart';
import 'package:paipfood_package/paipfood_package.dart';

class EndDrawerCategory extends StatefulWidget {
  final bool isEdit;
  final CategoryModel category;
  const EndDrawerCategory({required this.category, super.key, this.isEdit = false});

  @override
  State<EndDrawerCategory> createState() => _EndDrawerCategoryState();
}

class _EndDrawerCategoryState extends State<EndDrawerCategory> {
  late final store = context.read<MenuStore>();
  late CategoryModel newCategory = widget.category.clone();
  late final nameEC = TextEditingController(text: newCategory.name);
  final formKey = GlobalKey<FormState>();
  final descFocus = FocusNode();
  final nameFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return CwDialogEndDrawer(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: PSize.iii.paddingAll,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.isEdit ? context.i18n.tituloEditarCategoria : context.i18n.tituloCategoria, style: context.textTheme.headlineLarge),
                      PSize.vii.sizedBoxH,
                      ListenableBuilder(
                        listenable: store,
                        builder: (context, _) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: widget.isEdit ? MainAxisAlignment.end : MainAxisAlignment.spaceEvenly,
                                children: [
                                  if (widget.isEdit && newCategory.categoryType == CategoryType.product || widget.isEdit == false)
                                    CardSelectCategoryType(
                                      pathImage: PImages.product,
                                      label: context.i18n.produtos,
                                      body: context.i18n.descCategoriaProdutos,
                                      categoryType: CategoryType.product,
                                      isSelected: newCategory.categoryType == CategoryType.product,
                                      onTap: (categoryType) {
                                        if (widget.isEdit == false) {
                                          setState(() {
                                            store.changeCategoryType(category: newCategory, type: categoryType);
                                            nameEC.clear();
                                            newCategory.name = '';
                                            nameFocus.requestFocus();
                                          });

                                          return;
                                        }
                                      },
                                    ),
                                  if (widget.isEdit && newCategory.categoryType == CategoryType.pizza || widget.isEdit == false)
                                    CardSelectCategoryType(
                                      pathImage: PImages.flavorPizza,
                                      label: context.i18n.pizzas,
                                      body: context.i18n.descCategoriaPizza,
                                      categoryType: CategoryType.pizza,
                                      isSelected: newCategory.categoryType == CategoryType.pizza,
                                      onTap: (categoryType) {
                                        if (widget.isEdit == false) {
                                          setState(() {
                                            store.changeCategoryType(category: newCategory, type: categoryType);
                                            nameEC.text = context.i18n.pizzas;
                                            newCategory.name = nameEC.text;
                                            descFocus.requestFocus();
                                          });

                                          return;
                                        }
                                      },
                                    ),
                                ],
                              ),
                              PSize.iii.sizedBoxH,
                              CwTextFormFild(label: context.i18n.nomeDaCategoria, maskUtils: MaskUtils.cRequired(), autofocus: true, controller: nameEC, focusNode: nameFocus, onChanged: (value) => newCategory.name = value),
                              CwTextFormFild(label: context.i18n.descricao, initialValue: newCategory.description, focusNode: descFocus, onChanged: (value) => newCategory.description = value),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: PSize.ii.paddingAll,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PButton(
                    label: context.i18n.salvar,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        store.categorySelected = newCategory;
                        Navigator.of(context).pop();
                        if (newCategory.categoryType == CategoryType.pizza) {
                          if (!widget.isEdit) {
                            store.insertCategoryPizza(context: context, category: newCategory);
                          }
                          showDialog(context: context, builder: (context) => EndDrawerPizzaTab(category: newCategory));
                        } else {
                          store.insertCategory(newCategory);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
