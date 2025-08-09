import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/modules/menu/presenters/components/base_card_menu.dart';
import 'package:app/src/modules/order/order/aplication/stores/order_status_store.dart';
import 'package:app/src/modules/order/order/presenters/components/row_details_card_order.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ResumeOrder extends StatelessWidget {
  final OrderStatusStore store;
  const ResumeOrder({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return BaseCardMenu(
      width: double.infinity,
      children: [
        Padding(
          padding: PSize.i.paddingHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(context.i18n.itensPedido, style: context.textTheme.titleMedium), PSize.ii.sizedBoxH, ...store.order.cartProducts.map((e) => Padding(padding: const EdgeInsets.only(bottom: 4), child: RowDetailsCardOrder(cartProduct: e)))],
          ),
        ),
      ],
    );
  }
}
