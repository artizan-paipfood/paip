import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/dialog_end_drawer.dart';
import 'package:manager/src/modules/pdv/aplication/stores/cart_product_store.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/cart_product/header_info_cart_product.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/cart_product/increment_item_cart_button.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/cart_product/sliver_wrap_complements_cart_product.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/cart_product/sliver_wrap_sizes_cart_product.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/cart_product/tag_button_qty_flavor_pizza.dart';
import 'package:paipfood_package/paipfood_package.dart';

class EndDrawerProductToCart extends StatefulWidget {
  final ProductModel product;
  final CartProductDto? cartProduct;
  final Function(CartProductDto result) onSave;
  const EndDrawerProductToCart({required this.product, required this.onSave, super.key, this.cartProduct});

  @override
  State<EndDrawerProductToCart> createState() => _EndDrawerProductToCartState();
}

class _EndDrawerProductToCartState extends State<EndDrawerProductToCart> {
  late final store = context.read<CartProductStore>();
  var innerBoxIsScrolled0 = ValueNotifier(false);
  @override
  void initState() {
    store.init(product: widget.product, cartProduct: widget.cartProduct);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CwDialogEndDrawer(
      widthFactor: 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListenableBuilder(
              listenable: store,
              builder: (context, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 120,
                      child: Stack(
                        children: [
                          Hero(
                            tag: store.cartProdutVm!.product.id,
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                              child: CwImageCachedCustom(cacheKey: store.cartProdutVm!.product.imageCacheId, pathImage: store.cartProdutVm!.product.image, heidth: 200, width: double.infinity, iconEmptySize: 200 / 2),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 8, left: 8), child: BackButton(color: Colors.white)),
                          Padding(padding: const EdgeInsets.only(left: 50), child: HeaderInfoCartProduct(product: store.cartProdutVm!.product, store: store, colorText: Colors.white)),
                        ],
                      ),
                    ),
                    //Spaçamaneto AppBar
                    ValueListenableBuilder(
                      valueListenable: innerBoxIsScrolled0,
                      builder: (context, innerBoxIsScrolled, __) {
                        if (!innerBoxIsScrolled) return const SizedBox.shrink();
                        return Container(color: Colors.transparent, width: 50, height: 50);
                      },
                    ),
                    Expanded(
                      child: CustomScrollView(
                        shrinkWrap: true,
                        slivers: [
                          if (widget.product.sizes.isNotEmpty) SliverWrapSizesCartProduct(product: widget.product, store: store),
                          ...store.cartProdutVm!.product.getComplementsSortIndex.where((element) => element.items.isNotEmpty).map((complement) => SliverWrapComplementsCartProduct(complement: complement, store: store)),
                          MultiSliver(
                            children: [
                              Padding(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12), child: Align(alignment: Alignment.centerLeft, child: TagButtonQtyFlavorPizza(label: context.i18n.observacoes, colorSelected: Colors.black, isSelected: true))),
                              Padding(padding: const EdgeInsets.symmetric(horizontal: 12) + PSize.v.paddingBottom, child: CwTextFormFild(minLines: 2, maxLines: 4, hintText: context.i18n.observacoesDesc, onChanged: (value) => store.cartProdutVm!.observation = value)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: store.rebuildTotal,
                      builder: (context, _, __) {
                        final bool isValid = store.isValid();
                        return Material(
                          elevation: 50,
                          color: context.color.primaryBG,
                          child: DecoratedBox(
                            decoration: BoxDecoration(border: Border(top: BorderSide(color: context.color.secondaryText.withOpacity(0.8)))),
                            child: Padding(
                              padding: PSize.i.paddingAll,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  DecoratedBox(
                                    decoration: BoxDecoration(color: context.color.primaryText.withOpacity(0.05), borderRadius: 0.5.borderRadiusAll),
                                    child: IncrementItemCartButton(
                                      onIncrement: () {
                                        store.incrementQty();
                                      },
                                      onDecrement: () {
                                        store.decrementQty();
                                      },
                                      qty: store.cartProdutVm!.qty,
                                    ),
                                  ),
                                  PButton(
                                    label: store.cartProdutVm!.price > 0 ? "${context.i18n.adicionar.toUpperCase()} - ${(store.cartProdutVm!.price * store.cartProdutVm!.qty).toStringCurrency} " : context.i18n.adicionar,
                                    color: isValid ? PColors.primaryColor_ : Colors.grey,
                                    onPressed: () {
                                      if (isValid) {
                                        widget.onSave(store.saveCartProduct());
                                        Navigator.of(context).pop();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
