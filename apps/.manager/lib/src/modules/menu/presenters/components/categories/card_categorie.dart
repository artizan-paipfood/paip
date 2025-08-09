import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/switch_active_inative.dart';
import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:manager/src/modules/menu/presenters/components/categories/list_products.dart';
import 'package:manager/src/core/components/dialogs/dialog_delete.dart';
import 'package:manager/src/modules/menu/presenters/components/categories/end_drawer_category.dart';
import 'package:manager/src/modules/menu/presenters/components/pizzas/list_pizzas.dart';
import 'package:manager/src/modules/menu/presenters/components/categories/sub_card_categorie_pizza.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardCategorie extends StatefulWidget {
  final CategoryModel category;
  final bool isSelected;
  final void Function() onTap;
  final int index;
  const CardCategorie({required this.category, required this.isSelected, required this.onTap, required this.index, super.key});

  @override
  State<CardCategorie> createState() => _CardCategorieState();
}

class _CardCategorieState extends State<CardCategorie> {
  bool _isSelected() {
    if (widget.category.products.isEmpty || widget.isSelected) return true;
    return false;
  }

  late final store = context.read<MenuStore>();

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(3),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          InkWell(
            onTap: widget.onTap,
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(color: _isSelected() ? context.color.primaryColor : context.color.secondaryText.withOpacity(0.5), width: _isSelected() ? 2 : 1),
                borderRadius: BorderRadius.circular(3),
                color: context.color.primaryBG,
                boxShadow: const [BoxShadow(color: Color.fromRGBO(9, 30, 66, 0.25), blurRadius: 8, spreadRadius: -2, offset: Offset(0, 4)), BoxShadow(color: Color.fromRGBO(9, 30, 66, 0.08), spreadRadius: 1)],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ReorderableDragStartListener(index: widget.index, child: const Icon(PaipIcons.dragDropVertical)),
                            Column(children: [Text(widget.category.name, style: context.textTheme.titleLarge), if (widget.category.description.isNotEmpty) Text(widget.category.description, style: context.textTheme.bodySmall).center]),
                          ],
                        ),
                        Row(
                          children: [
                            PopupMenuButton(
                              icon: const Icon(Icons.more_vert),
                              elevation: 5,
                              tooltip: "",
                              color: context.color.surface,
                              surfaceTintColor: context.color.surface,
                              offset: const Offset(80, 0),
                              itemBuilder: (ctx) => [
                                CwPopMenuItem.icon(context, label: context.i18n.editar, icon: PaipIcons.edit, onTap: () => showDialog(context: context, builder: (context) => EndDrawerCategory(category: widget.category, isEdit: true))),
                                CwPopMenuItem.icon(
                                  context,
                                  label: context.i18n.deletar,
                                  icon: PaipIcons.trash,
                                  iconColor: context.color.errorColor,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => DialogDelete(
                                        onDelete: () async {
                                          if (widget.category.categoryType == CategoryType.pizza) {
                                            await store.deleteCategoryPizza(widget.category);
                                            return;
                                          }
                                          await store.deleteCategory(category: widget.category);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            CwSwitchActiveInative(
                              isActive: widget.category.visible,
                              onTap: () {
                                widget.category.visible = !widget.category.visible;
                                store.syncCategorie(widget.category);
                                return widget.category.visible;
                              },
                            ),
                            const SizedBox(width: 8),
                            IconButton(onPressed: widget.onTap, icon: Icon(_isSelected() ? PaipIcons.chevronUp : PaipIcons.chevronDown)),
                          ],
                        ),
                      ],
                    ),
                    if (widget.category.categoryType == CategoryType.pizza) SubCardCategoriePizza(category: widget.category),
                  ],
                ),
              ),
            ),
          ),
          if (_isSelected())
            ValueListenableBuilder(
              valueListenable: store.rebuildProdutcs,
              builder: (context, _, __) {
                return Column(
                  children: [
                    Builder(
                      builder: (context) {
                        if (widget.category.products.isEmpty) {
                          return CwEmptyState(size: 100, icon: PaipIcons.dropBox, bgColor: false, label: context.i18n.emptySateteProdutos);
                        }
                        if (widget.category.categoryType == CategoryType.pizza) {
                          if (widget.category.products.first.complements.firstWhere((complement) => complement.complementType == ComplementType.pizza).items.where((element) => element.isDeleted == false).isEmpty) {
                            return CwEmptyState(size: 100, icon: PaipIcons.dropBox, bgColor: false, label: context.i18n.emptySateteSaborPizza);
                          }
                          return ListPizzas(category: widget.category, store: store);
                        }
                        return ListProducts(category: widget.category, store: store);
                      },
                    ),
                    PSize.i.sizedBoxH,
                    if (store.productSelected == null && store.itemPizzaSelected == null)
                      PButton(
                        label: widget.category.categoryType == CategoryType.pizza ? context.i18n.adicionarSaborPizzaA(widget.category.name) : context.i18n.adicionarProdutoA(widget.category.name),
                        onPressed: () {
                          if (widget.category.categoryType == CategoryType.pizza) {
                            store.insertItemPizza(category: widget.category);
                            return;
                          }
                          store.insertProduct(widget.category);
                        },
                        icon: PaipIcons.add,
                      ),
                    PSize.i.sizedBoxH,
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
