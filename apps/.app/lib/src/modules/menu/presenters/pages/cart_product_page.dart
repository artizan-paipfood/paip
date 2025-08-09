import 'package:flutter/material.dart';

import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/core/helpers/breakpoints.dart';
import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/menu/presenters/view_models/cart_product_viewmodel.dart';
import 'package:app/src/modules/menu/presenters/view_models/menu_viewmodel.dart';
import 'package:app/src/modules/menu/presenters/components/cart_product/header_info_cart_product.dart';
import 'package:app/src/modules/menu/presenters/components/cart_product/sliver_list_complements_cart_product.dart';
import 'package:app/src/modules/menu/presenters/components/cart_product/sliver_list_sizes_cart_product.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CartProductPage extends StatefulWidget {
  final String? productId;
  const CartProductPage({this.productId, super.key});

  @override
  State<CartProductPage> createState() => _CartProductPageState();
}

class _CartProductPageState extends State<CartProductPage> {
  var innerBoxIsScrolled0 = ValueNotifier(false);
  late final store = context.read<CartProductViewmodel>();
  late final padding = MediaQuery.of(context).padding.top;
  late final menuStore = context.read<MenuViewmodel>();
  late final w = PaipBreakpoint.phone.isBreakpoint(context) ? context.w : 450;

  Future<void> _initialize(String? productId) async {
    if (productId == null) {
      return _goMenu();
    }
    final product = menuStore.getProductById(productId);
    if (product == null) {
      return _goMenu();
    }
    store.init(product: product);
  }

  void _goMenu() {
    final String establishmentId = Modular.stateOf(context).pathParameters[Routes.establishmentIdParam]!;
    context.go(Routes.menu(establishmentId: establishmentId));
  }

  @override
  void initState() {
    _initialize(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.primaryBG,
      body: StateNotifier(
        stateNotifier: menuStore.status,
        onComplete: (context) {
          if (widget.productId == null) {
            return const SizedBox.shrink();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    innerBoxIsScrolled0.value = innerBoxIsScrolled;
                    return [
                      SliverAppBar(
                        expandedHeight: w * 0.8,
                        surfaceTintColor: context.color.neutral100,
                        backgroundColor: context.color.primaryBG,
                        title: innerBoxIsScrolled ? Center(child: Padding(padding: const EdgeInsets.only(right: 40), child: Text(store.cartProdutVm!.product.name))) : null,
                        leading: CwIconButtonAppBar(
                          onPressed: () {
                            context.pop();
                          },
                        ),
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Hero(
                            tag: store.cartProdutVm!.product.id,
                            child: CwImageCachedCustom(cacheKey: store.cartProdutVm?.product.imageCacheId ?? '', pathImage: store.cartProdutVm?.product.image, secondaryPath: PImageBucket.emptyitem, heidth: 200, width: double.infinity, iconEmptySize: 200 / 2),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: ListenableBuilder(
                    listenable: store,
                    builder: (context, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: innerBoxIsScrolled0,
                            builder: (context, innerBoxIsScrolled, __) {
                              return AnimatedContainer(duration: 500.milliseconds, color: Colors.transparent, width: 50 + padding, height: innerBoxIsScrolled ? 50 + padding : 0);
                            },
                          ),
                          Expanded(
                            child: CustomScrollView(
                              shrinkWrap: true,
                              slivers: [
                                MultiSliver(children: [HeaderInfoCartProduct(product: store.cartProdutVm!.product, cartProductViewmodel: store)]),
                                if (store.cartProdutVm!.product.sizes.isNotEmpty) SliverListSizesCartProduct(product: store.cartProdutVm!.product, cartProductViewmodel: store),
                                ...store.cartProdutVm!.product.complements.where((element) => element.items.isNotEmpty).sorted((a, b) => a.index.compareTo(b.index)).map((complement) => SliverListComplementsCartProduct(complement: complement, cartProductViewmodel: store)),
                                MultiSliver(
                                  children: [
                                    Padding(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12), child: Align(alignment: Alignment.centerLeft, child: Text(context.i18n.observacoes, style: context.textTheme.titleLarge))),
                                    Padding(padding: const EdgeInsets.symmetric(horizontal: 12) + PSize.v.paddingBottom, child: CwTextFormFild(minLines: 2, maxLines: 4, hintText: context.i18n.observacoesDesc, onChanged: (value) => store.onChangeObservation(value))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Material(
                            elevation: 50,
                            color: context.color.primaryBG,
                            child: DecoratedBox(
                              decoration: BoxDecoration(border: Border(top: BorderSide(color: context.color.secondaryText.withOpacity(0.8)))),
                              child: Padding(
                                padding: PSize.i.paddingAll,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // DecoratedBox(
                                    //     decoration:
                                    //         BoxDecoration(color: context.color.primaryText.withOpacity(0.05), borderRadius: 0.5.borderRadiusAll),
                                    //     child: IncrementItemCartButton(
                                    //         onIncrement: () {
                                    //           store.incrementQty();
                                    //         },
                                    //         onDecrement: () {
                                    //           store.decrementQty();
                                    //         },
                                    //         qty: store.cartProdutVm!.qty)),
                                    // PSize.ii.sizedBoxW,
                                    Expanded(
                                      child: Hero(
                                        tag: "total",
                                        child: PButton(
                                          label: store.cartProdutVm!.price > 0 ? "${context.i18n.adicionar.toUpperCase()} - ${(store.cartProdutVm!.price * store.cartProdutVm!.qty).toStringCurrency} " : context.i18n.adicionar,
                                          color: store.isValid() ? PColors.primaryColor_ : Colors.grey,
                                          onPressed: () {
                                            if (store.isValid()) {
                                              menuStore.orderViewmodel.addProduct(store.cartProdutVm!);
                                              context.pop();
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
