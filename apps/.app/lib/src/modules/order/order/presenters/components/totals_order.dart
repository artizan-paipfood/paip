import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';

import 'package:app/src/modules/menu/presenters/components/base_card_menu.dart';
import 'package:app/src/modules/menu/presenters/components/cart_product/tag_button_qty_flavor_pizza.dart';
import 'package:app/src/modules/order/order/aplication/stores/order_status_store.dart';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class TotalsOrder extends StatelessWidget {
  final OrderStatusStore store;
  const TotalsOrder({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return BaseCardMenu(
      width: double.infinity,
      children: [
        Padding(
          padding: PSize.i.paddingHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRowEdit(context, label: context.i18n.subtota, value: store.order.getCartAmount),
              _buildRowEdit(context, label: context.i18n.taxaEntrega, value: store.order.orderType == OrderTypeEnum.takeWay ? 0 : store.order.deliveryTax),
              _buildRowEdit(context, label: context.i18n.desconto, value: store.order.discount, isNegative: true),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(context.i18n.total.toUpperCase(), style: context.textTheme.titleMedium), Text(store.order.getAmount.toStringCurrency, style: context.textTheme.titleMedium)]),
              PSize.ii.sizedBoxH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (store.order.isPaid) TagButtonQtyFlavorPizza(colorSelected: Colors.green, label: context.i18n.pago.toUpperCase(), isSelected: true),
                  const SizedBox.shrink(),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [Icon(store.order.paymentType?.icon ?? PaymentType.credit.icon), PSize.ii.sizedBoxW, Text(store.order.paymentType?.name.i18n() ?? '', style: context.textTheme.bodyMedium?.muted(context))]),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRowEdit(BuildContext context, {required String label, required double value, bool isNegative = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: context.textTheme.bodyMedium?.muted(context)),
        Text(value > 0.01 ? "${isNegative ? "-" : ""}${value.toStringCurrency}" : " -- ", style: context.textTheme.bodyMedium?.copyWith(color: (isNegative && value > 0.1) ? context.color.errorColor : null)),
      ],
    );
  }
}
