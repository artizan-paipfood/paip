import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';

import 'package:manager/src/modules/order/presenter/components/row_details_card_order.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardOrderResumeTableWidget extends StatelessWidget {
  final OrderModel order;
  final Widget? actionWidget;
  final Color? backGroundColor;
  final bool initiallyExpanded;

  const CardOrderResumeTableWidget({required this.order, this.actionWidget, this.initiallyExpanded = false, this.backGroundColor, super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      dense: true,
      backgroundColor: backGroundColor ?? context.color.white,
      collapsedBackgroundColor: backGroundColor ?? context.color.white,
      collapsedShape: RoundedRectangleBorder(borderRadius: PSize.i.borderRadiusAll),
      initiallyExpanded: initiallyExpanded,
      tilePadding: PSize.i.paddingHorizontal,
      shape: RoundedRectangleBorder(borderRadius: PSize.i.borderRadiusAll),
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(order.getOrderNumber), Text(order.createdAt!.pFactoryCountryFormatHHmm())]),
      subtitle: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('${order.cartProducts.length} ${order.cartProducts.length > 1 ? context.i18n.itens : context.i18n.item}'), Text(order.amount.toStringCurrency)]),
      children: [
        ...order.cartProducts.map((cp) => Padding(padding: PSize.i.paddingHorizontal + const EdgeInsets.only(bottom: 4), child: RowDetailsCardOrder(cartProduct: cp, showIconExpand: false, index: order.cartProducts.indexOf(cp), enableBorder: true))),
        const SizedBox(height: 8),
        if (actionWidget != null) actionWidget!,
      ],
    );
  }
}
