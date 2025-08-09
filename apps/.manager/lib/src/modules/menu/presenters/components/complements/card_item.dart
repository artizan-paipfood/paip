import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/dialogs/dialog_delete.dart';
import 'package:manager/src/core/components/switch_active_inative.dart';
import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:manager/src/modules/menu/presenters/components/complements/card_item_edit.dart';
import 'package:manager/src/modules/menu/presenters/components/end_drawer_cropper_image.dart';
import 'package:manager/src/modules/menu/presenters/components/price_widget.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardItem extends StatefulWidget {
  final ItemModel item;
  final ComplementModel complement;
  final int index;
  const CardItem({required this.item, required this.complement, required this.index, super.key});

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  late final store = context.read<MenuStore>();
  bool isSelected() {
    if ((store.itemSelected != null && store.itemSelected == widget.item) || (widget.item.createdAt == null && widget.item.syncState == SyncState.none)) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
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
                        child: Ink(
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
                                                  await store.deleteImageItem(widget.item);
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
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(child: Text(widget.item.name, style: context.textTheme.titleSmall)),
                                              Row(
                                                children: [
                                                  PopupMenuButton(
                                                    // enableFeedback: false,
                                                    elevation: 5,
                                                    tooltip: "",
                                                    color: context.color.surface,
                                                    surfaceTintColor: context.color.surface,
                                                    splashRadius: 18,
                                                    icon: const Icon(Icons.more_vert),

                                                    offset: const Offset(80, 0),
                                                    itemBuilder: (ctx) => [
                                                      CwPopMenuItem.icon(context, label: context.i18n.editar, icon: PaipIcons.edit, onTap: () => store.setItem(widget.item)),
                                                      CwPopMenuItem.icon(
                                                        context,
                                                        label: context.i18n.deletar,
                                                        icon: PaipIcons.trash,
                                                        iconColor: context.color.errorColor,
                                                        onTap: () {
                                                          showDialog(context: context, builder: (context) => DialogDelete(onDelete: () => store.deleteItem(widget.item)));
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  PSize.v.sizedBoxH,
                                                  PriceWidget(price: widget.item.price, promotionalPrice: widget.item.promotionalPrice),
                                                ],
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (isSelected()) CardItemEdit(item: widget.item, complement: widget.complement),
        ],
      ),
    );
  }
}
