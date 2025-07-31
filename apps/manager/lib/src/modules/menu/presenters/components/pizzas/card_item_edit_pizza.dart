import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:manager/src/core/components/dialogs/dialog_delete.dart';
import 'package:manager/src/modules/menu/presenters/components/end_drawer_cropper_image.dart';
import 'package:paipfood_package/paipfood_package.dart';
import '../../../../../core/components/switch_active_inative.dart';

class CardItemEditPizza extends StatefulWidget {
  final ItemModel item;
  const CardItemEditPizza({required this.item, super.key});

  @override
  State<CardItemEditPizza> createState() => _CardItemEditPizzaState();
}

class _CardItemEditPizzaState extends State<CardItemEditPizza> {
  late final store = context.read<MenuStore>();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
        CwTextFormFild(
          flex: 3,
          label: context.i18n.nome,
          expanded: true,
          initialValue: widget.item.name,
          onChanged: (value) => widget.item
            ..name = value
            ..syncState = SyncState.upsert,
          maskUtils: MaskUtils.cRequired(),
        ),
        PSize.iii.sizedBoxW,
        CwTextFormFild(
          flex: 2,
          label: context.i18n.preco,
          expanded: true,
          initialValue: Utils.doubleToStringDecimal(widget.item.price),
          onChanged: (value) => widget.item
            ..price = Utils.stringToDouble(value)
            ..syncState = SyncState.upsert,
          maskUtils: MaskUtils.currency(isRequired: true),
        ),
        PSize.ii.sizedBoxW,
        Column(
          children: [
            PSize.v.sizedBoxH,
            CwSwitchActiveInative(
              isActive: widget.item.visible,
              onTap: () {
                widget.item
                  ..visible = !widget.item.visible
                  ..syncState = SyncState.upsert;
                return widget.item.visible;
              },
            ),
            CwTextButton(
              label: context.i18n.deletar,
              icon: PaipIcons.trash,
              iconColor: context.color.errorColor,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => DialogDelete(
                    onDelete: () async {
                      store.deleteItemOptionalPizza(widget.item);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
