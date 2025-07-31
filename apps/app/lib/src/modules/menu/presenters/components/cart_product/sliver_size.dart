import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/modules/menu/presenters/view_models/cart_product_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SliverDelegateSize extends SliverPersistentHeaderDelegate {
  final CartProductViewmodel cartProductViewmodel;
  final BuildContext context;
  SliverDelegateSize({required this.cartProductViewmodel, required this.context});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 61,
      decoration: BoxDecoration(color: context.color.surface),
      child: Padding(
        padding: PSize.i.paddingVertical + PSize.ii.paddingHorizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(context.i18n.opcoes, style: context.textTheme.titleMedium), Text(context.i18n.descComplementRequiredObrigatio(1), style: context.textTheme.bodySmall)]),
            DecoratedBox(
              decoration: BoxDecoration(color: PColors.primaryColor_, borderRadius: 0.5.borderRadiusAll),
              child: Padding(padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8), child: Text(context.i18n.ok.toUpperCase(), style: context.textTheme.bodySmall?.copyWith(color: context.color.neutral100, fontWeight: FontWeight.bold)).center),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 61;

  @override
  double get minExtent => 61;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
