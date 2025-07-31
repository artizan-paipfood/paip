import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/dialogs/dialog_delete.dart';
import 'package:manager/src/core/components/switch_active_inative.dart';
import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:manager/src/modules/menu/presenters/components/categories/card_product_edit.dart';
import 'package:manager/src/modules/menu/presenters/components/complements/drag_complement_widget.dart';
import 'package:manager/src/modules/menu/presenters/components/end_drawer_cropper_image.dart';
import 'package:manager/src/modules/menu/presenters/components/price_widget.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardProduct extends StatefulWidget {
  final ProductModel product;
  final CategoryModel category;
  final int index;
  const CardProduct({required this.product, required this.category, required this.index, super.key});

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  late final store = context.read<MenuStore>();
  bool isSelected() {
    if ((store.productSelected != null && store.productSelected == widget.product) || (widget.product.createdAt == null && widget.product.syncState == SyncState.none)) {
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
              padding: const EdgeInsets.only(left: 18),
              child: DecoratedBox(
                decoration: BoxDecoration(border: Border(left: BorderSide(color: context.color.primaryColor, width: 3))),
                child: Row(
                  children: [
                    Container(color: context.color.primaryColor, width: 8, height: 3),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                        child: DragTarget<ComplementModel>(
                          onAcceptWithDetails: (data) {
                            store.addComplementToProduct(complement: data.data, product: widget.product);
                          },
                          builder: (context, candidateData, rejectedData) => Ink(
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Align(alignment: Alignment.centerLeft, child: ReorderableDragStartListener(index: widget.index, child: const Icon(PaipIcons.dragDropVertical))),
                                            CwImageWidget(
                                              cacheKey: widget.product.imageCacheIdThumb,
                                              imageBytes: widget.product.imageBytes,
                                              pathImage: widget.product.createdAt != null ? widget.product.imagePathThumb : null,
                                              size: 60,
                                              padding: 3,
                                              onTap: () async {
                                                await showDialog(
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
                                            PSize.i.sizedBoxW,
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [Text(widget.product.name, style: context.textTheme.titleLarge), Text(widget.product.description, style: context.textTheme.bodySmall?.copyWith(color: context.color.secondaryText))],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
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
                                                  CwPopMenuItem.icon(context, label: context.i18n.editar, icon: PaipIcons.edit, onTap: () => store.setProduct(widget.product)),
                                                  CwPopMenuItem.icon(
                                                    context,
                                                    label: context.i18n.deletar,
                                                    icon: PaipIcons.trash,
                                                    iconColor: context.color.errorColor,
                                                    onTap: () {
                                                      showDialog(context: context, builder: (context) => DialogDelete(onDelete: () async => store.deleteProduct(product: widget.product, category: widget.category)));
                                                    },
                                                  ),
                                                ],
                                              ),
                                              PSize.v.sizedBoxH,
                                              PSize.i.sizedBoxW,
                                              CwSwitchActiveInative(
                                                isActive: widget.product.visible,
                                                onTap: () {
                                                  widget.product.visible = !widget.product.visible;
                                                  store.syncProduct(widget.product);
                                                  return widget.product.visible;
                                                },
                                              ),
                                            ],
                                          ),
                                          PSize.i.sizedBoxH,
                                          PriceWidget(price: widget.product.price, priceFrom: widget.product.priceFrom, promotionalPrice: widget.product.promotionalPrice),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // const CwDivider(),
                                  if (widget.product.complements.isNotEmpty || candidateData.isNotEmpty)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: widget.product.complements.isEmpty ? 30 : null,
                                            decoration: BoxDecoration(border: Border.all(color: candidateData.isNotEmpty ? context.color.tertiaryColor : Colors.transparent), borderRadius: BorderRadius.circular(5)),
                                            child: Wrap(
                                              spacing: 8,
                                              runSpacing: 8,
                                              children: widget.product.complements
                                                  .where((element) => element.isDeleted == false)
                                                  .map(
                                                    (e) => DragComplementWidget(
                                                      complement: e,
                                                      isDragable: false,
                                                      onTap: () {
                                                        store.removeComplementToProduct(complement: e, product: widget.product);
                                                      },
                                                    ),
                                                  )
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
          if (isSelected()) CardProductEdit(product: widget.product, category: widget.category),
        ],
      ),
    );
  }
}
