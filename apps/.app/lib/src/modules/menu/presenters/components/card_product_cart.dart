import 'package:flutter/material.dart';

import 'package:app/l10n/l18n_extension.dart';

import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/menu/presenters/view_models/menu_viewmodel.dart';
import 'package:app/src/modules/menu/presenters/components/increment_decrement_itemcart.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardProductCart extends StatefulWidget {
  final CartProductDto cartProductVm;
  final void Function()? onAction;
  const CardProductCart({super.key, required this.cartProductVm, this.onAction});

  @override
  State<CardProductCart> createState() => _CardProductCartState();
}

class _CardProductCartState extends State<CardProductCart> {
  late ValueNotifier<int> qty = ValueNotifier(widget.cartProductVm.qty);
  late final store = context.read<MenuViewmodel>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Material(
        borderRadius: PSize.i.borderRadiusAll,
        child: InkWell(
          onTap: () {},
          borderRadius: PSize.i.borderRadiusAll,
          child: Ink(
            decoration: BoxDecoration(borderRadius: PSize.i.borderRadiusAll, color: context.color.primaryBG, border: Border.all(color: context.color.neutral300)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8) + PSize.i.paddingTop,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      if (widget.cartProductVm.product.image != null)
                                        Material(borderRadius: PSize.i.borderRadiusAll, clipBehavior: Clip.antiAliasWithSaveLayer, child: CwImageCached(cacheKey: widget.cartProductVm.product.imageCacheIdThumb, pathImage: widget.cartProductVm.product.imagePathThumb, size: 40)),
                                      const SizedBox(height: 40),
                                    ],
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: context.color.secondaryText.withOpacity(0.8)))),
                                            child: Text(widget.cartProductVm.product.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
                                          ),
                                          if (widget.cartProductVm.size != null)
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(context.i18n.opcao, style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                                                Row(
                                                  children: [
                                                    Expanded(child: Text("*  ${widget.cartProductVm.size!.name}", style: context.textTheme.bodySmall?.muted(context))),
                                                    Text(widget.cartProductVm.size!.price > 0 ? widget.cartProductVm.size!.price.toStringCurrency : " - ", style: context.textTheme.bodySmall?.muted(context)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ...widget.cartProductVm.getComplements().map(
                                                (e) => Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(e.name, style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                                                    ...widget.cartProductVm.getItemsCartByComplement(e).map(
                                                          (e) => Row(
                                                            children: [
                                                              Expanded(child: Text(e.descItem(qtyFlavorsPizza: widget.cartProductVm.qtyFlavorsPizza), style: context.textTheme.bodySmall?.muted(context))),
                                                              Text(e.price > 0 ? e.price.toStringCurrency : " - ", style: context.textTheme.bodySmall?.muted(context)),
                                                            ],
                                                          ),
                                                        ),
                                                  ],
                                                ),
                                              ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: ValueListenableBuilder(
                                valueListenable: qty,
                                builder: (context, _, __) {
                                  return IncrementDecrementItemCar(
                                    onIncrement: () {
                                      widget.cartProductVm.qty++;
                                      qty.value++;
                                      widget.onAction?.call();
                                    },
                                    onDecrement: () {
                                      if (widget.cartProductVm.qty <= 1) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text(context.i18n.desejaRemoverEsteItemDoCarrinho),
                                            actions: [
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: PButton(
                                                          autofocus: true,
                                                          label: context.i18n.removerItemDoCarrinho.toUpperCase(),
                                                          color: context.color.errorColor,
                                                          onPressed: () {
                                                            store.orderViewmodel.removeProduct(widget.cartProductVm);
                                                            widget.onAction?.call();
                                                            Navigator.of(context).pop();
                                                            if (store.orderViewmodel.order.cartProducts.isEmpty) {
                                                              Go.of(context).go(Routes.menu(establishmentId: store.establishment.id));
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  PSize.ii.sizedBoxH,
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: CwOutlineButton(
                                                          label: context.i18n.cancelar.toUpperCase(),
                                                          color: context.color.neutral950,
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                        return;
                                      }
                                      widget.cartProductVm.qty--;
                                      qty.value++;
                                      widget.onAction?.call();
                                    },
                                    qty: widget.cartProductVm.qty,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        // ignore: prefer_const_constructors
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (widget.cartProductVm.observation.isNotEmpty)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(color: context.color.primaryColor),
                                  child: Padding(padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4), child: Text(context.i18n.obs(widget.cartProductVm.observation).toUpperCase(), style: context.textTheme.bodySmall)),
                                ),
                              ),
                            ValueListenableBuilder(
                              valueListenable: qty,
                              builder: (context, _, __) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [Text(context.i18n.subTotalValor(widget.cartProductVm.price.toStringCurrency), style: context.textTheme.bodySmall), Text(context.i18n.totalMaisPreco(widget.cartProductVm.amount.toStringCurrency), style: context.textTheme.labelLarge)],
                                );
                              },
                            ),
                          ],
                        ),
                        PSize.i.sizedBoxH,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
