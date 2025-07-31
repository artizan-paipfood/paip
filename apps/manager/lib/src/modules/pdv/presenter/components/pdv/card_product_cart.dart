import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/pdv/aplication/stores/menu_pdv_store.dart';
import 'package:manager/src/modules/pdv/aplication/stores/order_pdv_store.dart';

import 'package:paipfood_package/paipfood_package.dart';

class CardProductCart extends StatefulWidget {
  final CartProductDto cartProductVm;

  const CardProductCart({required this.cartProductVm, super.key});

  @override
  State<CardProductCart> createState() => _CardProductCartState();
}

class _CardProductCartState extends State<CardProductCart> {
  late ValueNotifier<int> qty = ValueNotifier(widget.cartProductVm.qty);
  late final menuPdvStore = context.read<MenuPdvStore>();
  late final orderPdvStore = context.read<OrderPdvStore>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Material(
        borderRadius: PSize.i.borderRadiusAll,
        child: InkWell(
          onTap: () {},
          borderRadius: PSize.i.borderRadiusAll,
          child: Ink(
            decoration: BoxDecoration(borderRadius: PSize.i.borderRadiusAll, color: context.color.onPrimaryBG),
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
                                      Hero(
                                        transitionOnUserGestures: true,
                                        tag: widget.cartProductVm.product.id,
                                        child: Material(
                                          borderRadius: PSize.i.borderRadiusAll,
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          child: CwImageCached(cacheKey: widget.cartProductVm.product.imageCacheId, pathImage: widget.cartProductVm.product.image, size: 40),
                                        ).animate().moveX(begin: -50, end: 0, duration: 100.ms).then().scaleXY(alignment: Alignment.center, begin: 5, end: 1, curve: Curves.ease, duration: 400.ms),
                                      ),
                                      PSize.i.sizedBoxH,
                                      CircleAvatar(
                                        maxRadius: 13,
                                        backgroundColor: context.color.errorColor,
                                        child: ValueListenableBuilder(
                                          valueListenable: qty,
                                          builder: (context, _, __) {
                                            return Text(widget.cartProductVm.qty.toStringAsFixed(0), style: context.textTheme.labelMedium?.copyWith(color: Colors.white));
                                          },
                                        ),
                                      ).animate().moveX(begin: -50, end: 0, duration: 100.ms, delay: 100.ms).then().scaleXY(alignment: Alignment.center, begin: 5, end: 1, curve: Curves.ease, duration: 400.ms),
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
                                            child: Text(widget.cartProductVm.product.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold)),
                                          ),
                                          if (widget.cartProductVm.size != null)
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(context.i18n.opcao, style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                                                Row(
                                                  children: [
                                                    Expanded(child: Text("*  ${widget.cartProductVm.size!.name}", style: context.textTheme.bodySmall)),
                                                    Text(widget.cartProductVm.size!.price > 0 ? widget.cartProductVm.size!.price.toStringCurrency : " - ", style: context.textTheme.bodySmall),
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
                                                              Expanded(child: Text(e.descItem(qtyFlavorsPizza: widget.cartProductVm.qtyFlavorsPizza), style: context.textTheme.bodySmall)),
                                                              Text(e.price > 0 ? e.price.toStringCurrency : " - ", style: context.textTheme.bodySmall),
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
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                children: [
                                  Material(
                                    borderRadius: 100.0.borderRadiusAll,
                                    child: InkWell(
                                      borderRadius: 100.0.borderRadiusAll,
                                      onTap: () {
                                        widget.cartProductVm.qty++;
                                        qty.value++;
                                        orderPdvStore.rebuild();
                                      },
                                      child: Ink(decoration: BoxDecoration(color: PColors.neutral_.get300.withOpacity(0.4), borderRadius: 100.0.borderRadiusAll), child: Padding(padding: const EdgeInsets.all(7.0), child: Icon(PaipIcons.add, color: context.color.primaryText))),
                                    ),
                                  ),
                                  ValueListenableBuilder(
                                    valueListenable: qty,
                                    builder: (context, _, __) {
                                      return IconButton(
                                        onPressed: () {
                                          if (widget.cartProductVm.qty <= 1) {
                                            orderPdvStore.removePorduct(widget.cartProductVm);
                                            return;
                                          }
                                          widget.cartProductVm.qty--;
                                          qty.value--;
                                          orderPdvStore.rebuild();
                                        },
                                        icon: Icon(widget.cartProductVm.qty <= 1 ? PIcons.strokeRoundedDelete02 : PaipIcons.minus),
                                      );
                                    },
                                  ),
                                ],
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
                                  decoration: BoxDecoration(color: Colors.orange, borderRadius: 0.4.borderRadiusAll),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                                    child: Text(context.i18n.obs(widget.cartProductVm.observation).toUpperCase(), style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: context.color.white)),
                                  ),
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
