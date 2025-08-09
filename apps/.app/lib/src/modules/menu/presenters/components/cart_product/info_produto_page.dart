// import 'package:flutter/material.dart';
//
// import 'package:app/l10n/context_l10n_extension.dart';
// import 'package:app/src/core/helpers/routes.dart';
// import 'package:app/src/modules/menu/aplication/stores/cart_product_store.dart';
// import 'package:app/src/modules/menu/aplication/stores/menu_store.dart';
// import 'package:app/src/modules/menu/presenters/components/cart_product/header_info_cart_product.dart';
// import 'package:app/src/modules/menu/presenters/components/cart_product/increment_item_cart_button.dart';
// import 'package:app/src/modules/menu/presenters/components/cart_product/sliver_list_complements_cart_product.dart';
// import 'package:app/src/modules/menu/presenters/components/cart_product/sliver_list_sizes_cart_product.dart';
// import 'package:paipfood_package/paipfood_package.dart';

// class InfoprodutoPage extends StatefulWidget {
//   const InfoprodutoPage({
//     super.key,
//   });

//   @override
//   State<InfoprodutoPage> createState() => _InfoprodutoPageState();
// }

// class _InfoprodutoPageState extends State<InfoprodutoPage> {
//   var innerBoxIsScrolled0 = ValueNotifier(false);
//   late final store = context.read<CartProductStore>();
//   late final padding = MediaQuery.of(context).padding.top;
//   late final menuStore = context.read<MenuStore>();
//   late final w = context.responsive.isMobile ? context.w : 450;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: context.color.primaryBG,
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: NestedScrollView(
//                 headerSliverBuilder: (context, innerBoxIsScrolled) {
//                   innerBoxIsScrolled0.value = innerBoxIsScrolled;
//                   return [
//                     SliverAppBar(
//                       expandedHeight: w * 0.8,
//                       surfaceTintColor: context.color.neutral100,
//                       backgroundColor: context.color.primaryBG,
//                       title: innerBoxIsScrolled
//                           ? Center(
//                               child: Padding(
//                                 padding: const EdgeInsets.only(right: 40),
//                                 child: Text(store.cartProdutVm!.product.name),
//                               ),
//                             )
//                           : null,
//                       leading: CwIconButtonAppBar(
//                         onPressed: () {
//                           context.go(Routes.menu.route);
//                         },
//                       ),
//                       pinned: true,
//                       flexibleSpace: FlexibleSpaceBar(
//                         background: Hero(
//                           tag: store.cartProdutVm!.product.id,
//                           child: CwImageCachedCustom(
//                             cacheKey: store.cartProdutVm?.product.imageCacheId ?? '',
//                             pathImage: store.cartProdutVm?.product.image,
//                             secondaryPath: PImageBucket.emptyitem,
//                             heidth: 200,
//                             width: double.infinity,
//                             iconEmptySize: 200 / 2,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ];
//                 },
//                 body: ListenableBuilder(
//                     listenable: store,
//                     builder: (context, _) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ValueListenableBuilder(
//                               valueListenable: innerBoxIsScrolled0,
//                               builder: (context, innerBoxIsScrolled, __) {
//                                 return AnimatedContainer(
//                                   duration: 500.milliseconds,
//                                   color: Colors.transparent,
//                                   width: 50 + padding,
//                                   height: innerBoxIsScrolled ? 50 + padding : 0,
//                                 );
//                               }),
//                           Expanded(
//                             child: CustomScrollView(shrinkWrap: true, slivers: [
//                               MultiSliver(children: [
//                                 HeaderInfoCartProduct(product: store.cartProdutVm!.product, store: store),
//                               ]),
//                               if (store.cartProdutVm!.product.sizes.isNotEmpty)
//                                 SliverListSizesCartProduct(product: store.cartProdutVm!.product, store: store),
//                               ...store.cartProdutVm!.product.complements
//                                   .where((element) => element.items.isNotEmpty)
//                                   .sorted((a, b) => a.index.compareTo(b.index))
//                                   .map((complement) => SliverListComplementsCartProduct(complement: complement, store: store)),
//                               MultiSliver(children: [
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       context.i18n.observacoes,
//                                       style: context.textTheme.titleLarge,
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 12) + PSize.v.paddingBottom,
//                                   child: CwTextFormFild(
//                                     minLines: 2,
//                                     maxLines: 4,
//                                     hintText: context.i18n.observacoesDesc,
//                                     onChanged: (value) => store.cartProdutVm!.observation = value,
//                                   ),
//                                 ),
//                               ])
//                             ]),
//                           ),
//                           ValueListenableBuilder(
//                               valueListenable: store.rebuildTotal,
//                               builder: (context, _, __) {
//                                 final bool isValid = store.isValid;
//                                 return Material(
//                                   elevation: 50,
//                                   color: context.color.primaryBG,
//                                   child: DecoratedBox(
//                                     decoration: BoxDecoration(
//                                         border: Border(
//                                       top: BorderSide(color: context.color.secondaryText.withOpacity(0.8)),
//                                     )),
//                                     child: Padding(
//                                       padding: PSize.i.paddingAll,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           DecoratedBox(
//                                               decoration: BoxDecoration(
//                                                   color: context.color.primaryText.withOpacity(0.05), borderRadius: 0.5.borderRadiusAll),
//                                               child: IncrementItemCartButton(
//                                                   onIncrement: () {
//                                                     store.incrementQty();
//                                                   },
//                                                   onDecrement: () {
//                                                     store.decrementQty();
//                                                   },
//                                                   qty: store.cartProdutVm!.qty)),
//                                           PSize.ii.sizedBoxW,
//                                           Expanded(
//                                             child: Hero(
//                                               tag: context.i18n.total,
//                                               child: CwButton(
//                                                 label: store.cartProdutVm!.price > 0
//                                                     ? "${context.i18n.adicionar.toUpperCase()} - ${(store.cartProdutVm!.price * store.cartProdutVm!.qty).toStringCurrency} "
//                                                     : context.i18n.adicionar,
//                                                 color: isValid ? PColors.primaryColor_ : Colors.grey,
//                                                 onPressed: () {
//                                                   if (isValid) {
//                                                     menuStore.addProduct(store.cartProdutVm!);
//                                                     context.pop();
//                                                   }
//                                                 },
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               })
//                         ],
//                       );
//                     }),
//               ),
//             ),
//           ],
//         ));
//   }
// }

// // class SliverDelegateDescProduct extends SliverPersistentHeaderDelegate {
// //   final ProductModel product;
// //   SliverDelegateDescProduct({
// //     required this.product,
// //   });
// //   @override
// //   Widget build(
// //     BuildContext context,
// //     double shrinkOffset,
// //     bool overlapsContent,
// //   ) {
// //     return ;
// //   }

// //   @override
// //   double get maxExtent => 61;

// //   @override
// //   double get minExtent => 61;

// //   @override
// //   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
// //     return true;
// //   }
// // }
