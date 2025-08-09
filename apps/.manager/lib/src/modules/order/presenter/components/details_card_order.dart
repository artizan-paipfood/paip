import 'package:artizan_ui/artizan_ui.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/order/presenter/components/row_details_card_order.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DetailsCardOrder extends StatelessWidget {
  final OrderModel order;

  final void Function() onPrintOrder;
  final void Function() onCancelOrder;

  const DetailsCardOrder({required this.order, required this.onPrintOrder, required this.onCancelOrder, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...order.cartProducts.map((e) => Padding(padding: const EdgeInsets.only(bottom: 4), child: RowDetailsCardOrder(cartProduct: e))),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildRow(context, title: "${context.i18n.carrinho}:", value: order.getCartAmount.toStringCurrency),
              if (order.orderType == OrderTypeEnum.delivery) _buildRow(context, title: "${context.i18n.taxaEntrega}:", value: order.deliveryTax.toStringCurrency),
              _buildRow(context, title: "${context.i18n.subtotal}:", value: order.subTotal.toStringCurrency),
              if (order.discount > 0) _buildRow(context, title: "${context.i18n.desconto}:", value: "-${order.discount.toStringCurrency}", color: context.color.errorColor),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("${context.i18n.total}:".toUpperCase(), style: context.textTheme.bodyLarge), Text(order.amount.toStringCurrency, style: context.textTheme.bodyLarge)]),
              if (order.paymentType == PaymentType.cash && order.getChange > 0) _buildRow(context, title: "${context.i18n.trocop}: ${order.changeTo.toStringCurrency}".toUpperCase(), value: "+${order.getChange.toStringCurrency}", color: PColors.primaryColor_),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (order.status != OrderStatusEnum.canceled || order.status != OrderStatusEnum.losted || order.status != OrderStatusEnum.delivered) ArtButton.destructive(child: Text(context.i18n.cancelarPedido), onPressed: () => onCancelOrder.call()),
            PSize.spacer.sizedBoxW,
            ArtButton.outline(child: Text(context.i18n.imprimir), onPressed: () => onPrintOrder.call()),
          ],
        ),
      ],
    );
  }

  Widget _buildRow(BuildContext context, {required String title, required String value, Color? color}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title.toUpperCase(), style: context.textTheme.bodySmall), Text(value, style: context.textTheme.bodySmall?.copyWith(color: color))]);
  }
}
