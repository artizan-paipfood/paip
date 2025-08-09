import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/divider.dart';
import 'package:manager/src/modules/order/presenter/components/row_details_card_order.dart';
import 'package:manager/src/modules/pdv/aplication/stores/payment/i_payment_controller.dart';
import 'package:paipfood_package/paipfood_package.dart';

class FinishOrderDataComponent extends StatelessWidget {
  final IPaymentController store;
  const FinishOrderDataComponent({required this.store, super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.color.surface,
      child: Padding(
        padding: PSize.ii.paddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween)]),
            const CwDivider(),
            Text(context.i18n.itens, style: context.textTheme.titleLarge),
            Expanded(
              child: ListView.builder(
                itemCount: store.orders.first.cartProducts.length,
                itemBuilder: (context, index) {
                  final cartProduct = store.orders.first.cartProducts[index];
                  return Padding(padding: PSize.i.paddingBottom, child: RowDetailsCardOrder(cartProduct: cartProduct, index: index, enableBorder: true, showIconExpand: false));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
