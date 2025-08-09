import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/pdv/aplication/stores/cart_product_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SliverDelegateComplement extends SliverPersistentHeaderDelegate {
  final ComplementModel complement;
  final CartProductStore store;
  final BuildContext context;
  SliverDelegateComplement({required this.complement, required this.store, required this.context});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    String getDescription() {
      int qtyMin = complement.qtyMin;
      final int qtyMax = complement.qtyMax;
      final bool isPizza = complement.complementType == ComplementType.pizza;
      if (isPizza) qtyMin = store.cartProdutVm!.qtyFlavorsPizza!.qty;

      if (isPizza) {
        if ((isPizza && qtyMin == 1) || (qtyMin == 1 && qtyMin == complement.qtyMax)) {
          return context.i18n.descComplementPizza(qtyMin);
        }
        if ((isPizza && qtyMin > 1) || (qtyMin > 1 && qtyMin == complement.qtyMax)) {
          return context.i18n.descComplementPizzaPlural(qtyMin);
        }
      }

      if (qtyMin == 1) {
        if (complement.qtyMax > 1) return "${context.i18n.descComplementObrigatio(qtyMin)} ${context.i18n.descComplementAte(qtyMax).toLowerCase()}";
        return context.i18n.descComplementObrigatio(qtyMin);
      }
      if (qtyMin > 1) {
        if (complement.qtyMax > 1) {
          return "${context.i18n.descComplementObrigatioPlural(qtyMin)} ${context.i18n.descComplementAte(qtyMax).toLowerCase()}";
        }
        return context.i18n.descComplementObrigatioPlural(qtyMin);
      }
      if (complement.qtyMax == 1) {
        return context.i18n.descComplementLivre(complement.qtyMax);
      }
      if (complement.qtyMax > 1) {
        return context.i18n.descComplementLivrePlural(complement.qtyMax);
      }
      return context.i18n.descComplementLivreIlimitado;
    }

    final bool isValid = store.cartProdutVm!.complementIsValid(complement);
    return Container(
      height: 61,
      decoration: BoxDecoration(color: context.color.surface),
      child: Padding(
        padding: PSize.i.paddingVertical + PSize.ii.paddingHorizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(complement.name, style: context.textTheme.titleMedium),
                    PSize.iii.sizedBoxW,
                    if (complement.complementType == ComplementType.pizza)
                      ...store.cartProdutVm!.getItemsByComplement(complement).map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                constraints: const BoxConstraints(maxWidth: 80, minWidth: 20),
                                decoration: BoxDecoration(color: context.color.primaryText.withOpacity(0.1), borderRadius: 0.3.borderRadiusAll),
                                child: Padding(padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4), child: Text(e.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textTheme.bodySmall)),
                              ),
                            ),
                          ),
                  ],
                ),
                Text(getDescription(), style: context.textTheme.bodySmall),
              ],
            ),
            if (complement.isRequired || complement.complementType == ComplementType.pizza)
              DecoratedBox(
                decoration: BoxDecoration(color: isValid ? PColors.primaryColor_ : context.color.neutral900, borderRadius: 0.5.borderRadiusAll),
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5), child: Text(isValid ? "OK" : context.i18n.obrigatorio.toUpperCase(), style: context.textTheme.bodyMedium?.copyWith(color: context.color.neutral100, fontSize: 10)).center),
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
