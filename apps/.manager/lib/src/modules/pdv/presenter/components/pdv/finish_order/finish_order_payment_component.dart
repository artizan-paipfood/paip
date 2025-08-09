import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/pdv/aplication/stores/order_pdv_store.dart';
import 'package:manager/src/modules/pdv/aplication/stores/payment/i_payment_controller.dart';
import 'package:manager/src/modules/pdv/aplication/stores/payment/payment_bill_controller.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/finish_order/card_payment_type_order.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/finish_order/card_totals_order.dart';
import 'package:paipfood_package/paipfood_package.dart';

class FinishOrderPaymentComponent extends StatefulWidget {
  final IPaymentController controller;
  final void Function(bool isFinish) onPay;

  const FinishOrderPaymentComponent({required this.controller, required this.onPay, super.key});

  @override
  State<FinishOrderPaymentComponent> createState() => _FinishOrderPaymentComponentState();
}

class _FinishOrderPaymentComponentState extends State<FinishOrderPaymentComponent> {
  late final OrderPdvStore store = context.read<OrderPdvStore>();
  late final payEC = TextEditingController(text: Utils.maskUltisToString(widget.controller.remainingTotal.toStringAsFixed(2), MaskUtils.currency()));
  final observationsEC = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _onChangePaymentType(PaymentType payment) {
    if (widget.controller.paymentType == PaymentType.cash) {
      payEC.text = Utils.maskUltisToString(widget.controller.remainingTotal.toStringAsFixed(2), MaskUtils.currency());
    }
    if (payment == PaymentType.cash && widget.controller.changeTo > 0) {
      payEC.text = Utils.maskUltisToString(widget.controller.changeTo.toStringAsFixed(2), MaskUtils.currency());
    }
    widget.controller.setPaymentType(payment);
  }

  @override
  void dispose() {
    payEC.dispose();
    super.dispose();
  }

  bool _validateForms() {
    return (store.customerFormKey.currentState?.validate() ?? true) && (store.customerFinishOrderFormKey.currentState?.validate() ?? true) && (_formKey.currentState?.validate() ?? true);
  }

  Future<void> _onPay(BuildContext context) async {
    Loader.show(context);
    final isFinish = await widget.controller.onPay(value: Utils.stringToDouble(payEC.text), paymentType: widget.controller.paymentType, observation: observationsEC.text);
    observationsEC.clear();
    toast.showSucess("Pagamento realizado", duration: 2.seconds, alignment: Alignment.bottomRight);
    await Future.delayed(1.seconds, () {
      widget.controller.notify();
      payEC.text = Utils.maskUltisToString(widget.controller.remainingTotal.toStringAsFixed(2), MaskUtils.currency());
    });
    Loader.hide();
    if (isFinish) {
      if (context.mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PSize.ii.paddingAll,
      child: ListenableBuilder(
        listenable: widget.controller,
        builder: (context, _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(context.i18n.pagamentos, style: context.textTheme.titleMedium),
                      ...widget.controller.payments.map(
                        (e) => ListTile(
                          trailing: Icon(e.paymentType.icon),
                          title: Text(e.paymentType.name.i18n()),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text(Utils.maskUltisToString(e.value.toStringAsFixed(2), MaskUtils.currency())), Text(e.observation ?? '', style: context.textTheme.bodySmall?.copyWith(color: context.color.muted))],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(context.i18n.formasPagamento),
                      ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: widget.controller.paymentMethodsAvaliable
                                .map(
                                  (payment) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CardPaymentTypeOrder(
                                      onTap: () {
                                        setState(() => _onChangePaymentType(payment));
                                      },
                                      paymentType: payment,
                                      isSelected: widget.controller.paymentType == payment,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      PSize.i.sizedBoxH,
                      CardTotalsOrder(controller: widget.controller, payEC: payEC),
                      CwTextFormFild(label: context.i18n.observacoes, controller: observationsEC, maxLines: 3, minLines: 1),
                      PSize.i.sizedBoxH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PButton(
                            color: context.color.black,
                            colorText: context.color.white,
                            label: context.i18n.voltar,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: context.color.neutral400), color: Colors.black),
                            width: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CwTextFormFild(
                                      controller: payEC,
                                      enabled: widget.controller is PaymentBillController,
                                      maskUtils: MaskUtils.currency(
                                        customValidate: (value) {
                                          if (value.isEmpty) {
                                            return context.i18n.campoObrigatorio;
                                          }
                                          if (value == '0,00') {
                                            return context.i18n.campoObrigatorio;
                                          }
                                          final result = Utils.stringToDouble(value);
                                          if ((widget.controller.paymentType != PaymentType.cash) && (result - widget.controller.remainingTotal > 0.02)) {
                                            return context.i18n.valorPagamentoMaiorQueConta;
                                          }
                                          return null;
                                        },
                                      ),
                                      prefixIcon: IconButton(
                                        icon: const Icon(PIcons.strokeRoundedDollar01),
                                        onPressed: () {
                                          payEC.text = Utils.maskUltisToString(widget.controller.remainingTotal.toStringAsFixed(2), MaskUtils.currency());
                                        },
                                      ),
                                    ),
                                  ),
                                  PSize.i.sizedBoxW,
                                  PButton(
                                    label: context.i18n.pagar.toUpperCase(),
                                    onPressedFuture: () async {
                                      if (_validateForms()) {
                                        await _onPay(context);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
