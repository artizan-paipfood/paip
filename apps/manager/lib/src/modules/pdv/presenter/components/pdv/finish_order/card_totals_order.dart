import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/pdv/aplication/stores/payment/i_payment_controller.dart';
import 'package:manager/src/modules/pdv/aplication/stores/payment/payment_order_controller.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/finish_order/row_title_value_order.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardTotalsOrder extends StatefulWidget {
  final IPaymentController controller;
  final TextEditingController payEC;
  const CardTotalsOrder({required this.controller, required this.payEC, super.key});

  @override
  State<CardTotalsOrder> createState() => _CardTotalsOrderState();
}

class _CardTotalsOrderState extends State<CardTotalsOrder> {
  String get _currency => LocaleNotifier.instance.currency;
  @override
  Widget build(BuildContext context) {
    log(widget.controller.runtimeType.toString());
    return DecoratedBox(
      decoration: BoxDecoration(color: context.color.onPrimaryBG, borderRadius: PSize.i.borderRadiusAll),
      child: Column(
        children: [
          0.5.sizedBoxH,
          Padding(
            padding: PSize.i.paddingHorizontal,
            child: Column(
              children: [
                RowTitleValueOrder(title: "${context.i18n.carrinho}:", value: widget.controller.total.toStringCurrency),
                if (widget.controller is PaymentOrderController) RowTitleValueOrder(title: "${context.i18n.taxaEntrega}:", value: widget.controller.deliveryTax.toStringCurrency),
                RowTitleValueOrder(title: "${context.i18n.subtotal}:", value: widget.controller.subTotal.toStringCurrency),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${context.i18n.desconto}:"),
                    SizedBox(
                      width: 120,
                      child: CwTextFormFild(
                        initialValue: widget.controller.discount.toStringAsFixed(2),
                        onChanged: (value) => setState(() {
                          widget.controller.onDiscount(Utils.stringToDouble(value));
                        }),
                        maskUtils: MaskUtils.currency(),
                        prefixText: "$_currency -",
                        fillColor: context.color.neutral100,
                        // constraints: const BoxConstraints(maxHeight: 30),
                        textColor: context.color.errorColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${context.i18n.taxaServico}:"),
                    SizedBox(
                      width: 120,
                      child: CwTextFormFild(
                        initialValue: widget.controller.changeTo.toStringAsFixed(2),
                        onChanged: (value) {
                          setState(() {
                            widget.controller.onServiceTax(Utils.stringToDouble(value));
                          });
                        },
                        maskUtils: MaskUtils.currency(),
                        prefixText: "$_currency ",
                        fillColor: context.color.neutral100,
                      ),
                    ),
                  ],
                ),
                if (widget.controller.paymentType == PaymentType.cash)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${context.i18n.trocoPara}:"),
                      Row(
                        children: [
                          if (widget.controller.remainingTotal <= (widget.controller.changeTo)) Text("+ ${((widget.controller.changeTo) - widget.controller.remainingTotal).toStringCurrency} ", style: context.textTheme.bodyMedium?.copyWith(color: PColors.primaryColor_)),
                          SizedBox(
                            width: 120,
                            child: CwTextFormFild(
                              initialValue: widget.controller.changeTo.toStringAsFixed(2),
                              onChanged: (value) => setState(() {
                                widget.controller.onChangeTo(Utils.stringToDouble(value));
                                widget.payEC.text = value;
                              }),
                              maskUtils: MaskUtils.currency(),
                              prefixText: "$_currency ",
                              fillColor: context.color.neutral100,
                              textColor: (widget.controller.remainingTotal >= (widget.controller.changeTo)) ? Colors.orange : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
          0.5.sizedBoxH,
          DecoratedBox(
            decoration: BoxDecoration(color: context.color.neutral100, borderRadius: PSize.i.borderRadiusBottomLeft + PSize.i.borderRadiusBottomRight),
            child: Padding(
              padding: PSize.i.paddingAll,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("A PAGAR:", style: context.textTheme.titleLarge).center, Text(widget.controller.remainingTotal.toStringCurrency, style: context.textTheme.titleLarge).center]),
            ),
          ),
        ],
      ),
    );
  }
}
