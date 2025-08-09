import 'package:flutter/material.dart';

import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:manager/src/core/components/dialogs/dialog_delete.dart';
import 'package:manager/src/modules/menu/presenters/components/end_drawer_cropper_image.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/menu/presenters/components/pizzas/pizza_qty_selector.dart';
import '../../../../../core/components/switch_active_inative.dart';

class CardProductSizePizza extends StatefulWidget {
  final ProductModel product;
  const CardProductSizePizza({required this.product, super.key});

  @override
  State<CardProductSizePizza> createState() => _CardProductSizePizzaState();
}

class _CardProductSizePizzaState extends State<CardProductSizePizza> {
  late final store = context.read<MenuStore>();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CwImageWidget(
          cacheKey: widget.product.imageCacheId,
          imageBytes: widget.product.imageBytes,
          pathImage: widget.product.createdAt != null ? widget.product.image : null,
          size: 60,
          padding: 3,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => EndDrawerCropperImage(
                label: widget.product.name,
                delete: () async {
                  await store.deleteImageProduct(widget.product);
                },
                initStateFunc: (controller) {
                  if (widget.product.imageBytes != null) {
                    controller.imagePicker = widget.product.imageBytes;
                  }
                },
                saveImage: (image) async {
                  if (image != null) {
                    await store.saveImageProduct(bytes: image, product: widget.product);
                  }
                },
              ),
            );
          },
        ),
        CwTextFormFild(
          label: context.i18n.tamanhoLabel,
          expanded: true,
          initialValue: widget.product.name,
          onChanged: (value) => widget.product
            ..name = value
            ..syncState = SyncState.upsert,
          maskUtils: MaskUtils.cRequired(),
        ),
        PSize.iii.sizedBoxW,
        Column(
          children: [
            Text(context.i18n.quantidadeSabores, style: context.textTheme.labelMedium, overflow: TextOverflow.ellipsis),
            0.5.sizedBoxH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: QtyFlavorsPizza.values
                  .map(
                    (qty) => PizzaQtySelector(
                      qty: qty,
                      onTap: (value) {
                        setState(() {
                          widget.product
                            ..qtyFlavorsPizza = value
                            ..syncState = SyncState.upsert;
                        });
                      },
                      isSelected: widget.product.qtyFlavorsPizza == qty,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
        PSize.ii.sizedBoxW,
        Column(
          children: [
            PSize.iii.sizedBoxH,
            CwSwitchActiveInative(
              isActive: widget.product.visible,
              onTap: () {
                widget.product
                  ..visible = !widget.product.visible
                  ..syncState = SyncState.upsert;
                return widget.product.visible;
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
                      await store.deleteProductPizza(widget.product);
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
