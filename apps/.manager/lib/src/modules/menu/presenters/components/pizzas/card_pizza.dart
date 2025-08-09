import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/switch_active_inative.dart';
import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:manager/src/core/components/dialogs/dialog_delete.dart';
import 'package:manager/src/modules/menu/presenters/components/end_drawer_cropper_image.dart';
import 'package:manager/src/modules/menu/presenters/components/pizzas/card_pizza_edit.dart';
import 'package:manager/src/modules/menu/presenters/components/pizzas/size_price_pizza_widget.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardPizza extends StatefulWidget {
  final ItemModel item;
  final ComplementModel complement;
  final CategoryModel category;
  final int index;
  const CardPizza({required this.item, required this.complement, required this.category, required this.index, super.key});

  @override
  State<CardPizza> createState() => _CardPizzaState();
}

class _CardPizzaState extends State<CardPizza> {
  late final store = context.read<MenuStore>();
  bool isSelected() {
    if ((store.itemPizzaSelected != null && store.itemPizzaSelected == widget.item) || (widget.item.createdAt == null && widget.item.syncState == SyncState.none)) {
      return true;
    }

    return false;
  }

  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isSelected())
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: DecoratedBox(
              decoration: BoxDecoration(border: Border(left: BorderSide(color: context.color.primaryColor, width: 3))),
              child: Row(
                children: [
                  Container(color: context.color.primaryColor, width: 8, height: 3),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                      child: InkWell(
                        onHover: (value) => setState(() => _isHover = value),
                        onTap: () {},
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: context.color.primaryBG,
                            boxShadow: const [BoxShadow(color: Color.fromRGBO(9, 30, 66, 0.25), blurRadius: 8, spreadRadius: -2, offset: Offset(0, 4)), BoxShadow(color: Color.fromRGBO(9, 30, 66, 0.08), spreadRadius: 1)],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        ReorderableDragStartListener(index: widget.index, child: const Icon(PaipIcons.dragDropVertical)),
                                        CwImageWidget(
                                          cacheKey: widget.item.imageCacheId,
                                          imageBytes: widget.item.imageBytes,
                                          pathImage: widget.item.image,
                                          size: 60,
                                          padding: 3,
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => EndDrawerCropperImage(
                                                label: widget.item.name,
                                                delete: () async {
                                                  final message = context.i18n.feedbackSucessImagemDeletada;
                                                  Navigator.of(context).pop();
                                                  await store.deleteImageItem(widget.item);
                                                  toast.showSucess(message);
                                                },
                                                initStateFunc: (controller) {
                                                  if (widget.item.imageBytes != null) {
                                                    controller.imagePicker = widget.item.imageBytes;
                                                  }
                                                },
                                                saveImage: (image) async {
                                                  if (image != null) {
                                                    await store.saveImageItem(bytes: image, item: widget.item);
                                                  }
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(child: Text(widget.item.name, style: context.textTheme.titleLarge)),
                                              if (_isHover)
                                                PopupMenuButton(
                                                  icon: const Icon(Icons.more_vert),
                                                  elevation: 5,
                                                  tooltip: "",
                                                  color: context.color.surface,
                                                  surfaceTintColor: context.color.surface,
                                                  offset: const Offset(80, 0),
                                                  itemBuilder: (ctx) => [
                                                    CwPopMenuItem.icon(context, label: context.i18n.editar, icon: PaipIcons.edit, onTap: () => store.setItemPizza(widget.item)),
                                                    CwPopMenuItem.icon(
                                                      context,
                                                      label: context.i18n.deletar,
                                                      icon: PaipIcons.trash,
                                                      iconColor: context.color.errorColor,
                                                      onTap: () {
                                                        showDialog(context: context, builder: (context) => DialogDelete(onDelete: () => store.deleteItemPizza(category: widget.category, complement: widget.complement, item: widget.item)));
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              CwSwitchActiveInative(
                                                isActive: widget.item.visible,
                                                onTap: () {
                                                  widget.item.visible = !widget.item.visible;
                                                  store.syncItem(widget.item);
                                                  return widget.item.visible;
                                                },
                                              ),
                                            ],
                                          ),
                                          Text(widget.item.description, style: context.textTheme.bodySmall?.copyWith(color: context.color.secondaryText)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 30,
                                        child: Wrap(
                                          alignment: WrapAlignment.end,
                                          crossAxisAlignment: WrapCrossAlignment.end,
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: widget.item.sizesDescByPrice
                                              .where((element) => element.isDeleted == false && widget.category.productById(element.productId)!.isDeleted == false)
                                              .map((e) => SizePricePizzaWidget(product: widget.category.productById(e.productId)!, size: e))
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (isSelected()) CardPizzaEdit(item: widget.item, complement: widget.complement, category: widget.category),
      ],
    );
  }
}
