import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/config/sub_modules/payments/presenters/viewmodels/payments_viewmodel.dart';
import 'package:manager/src/modules/config/sub_modules/payments/presenters/components/card_payment.dart';
import 'package:manager/src/modules/config/sub_modules/payments/presenters/components/pix_card_component.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PaymentMethodsComponent extends StatelessWidget {
  final PaymentsViewmodel store;
  const PaymentMethodsComponent({required this.store, super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        return Wrap(
          children: [
            CardPayment(
              label: context.i18n.cash,
              orderTypes: store.getOrderTypesByPaymentType(PaymentType.cash).toSet(),
              icon: PIcons.strokeRoundedDollarSquare,
              value: store.paymentIsEnable(PaymentType.cash),
              onChanged: (value) {
                store.switchPaymentType(paymentType: PaymentType.cash, value: value);
              },
              onOrderTypeChanged: (orderTypes) {
                store.updateOrderTypesByPaymentType(paymentType: PaymentType.cash, orderTypes: orderTypes.toList());
              },
            ),
            CardPayment(
              label: context.i18n.credit,
              icon: PIcons.strokeRoundedCreditCard,
              value: store.paymentIsEnable(PaymentType.credit),
              onChanged: (value) {
                store.switchPaymentType(paymentType: PaymentType.credit, value: value);
              },
              orderTypes: store.getOrderTypesByPaymentType(PaymentType.credit).toSet(),
              onOrderTypeChanged: (orderTypes) {
                store.updateOrderTypesByPaymentType(paymentType: PaymentType.credit, orderTypes: orderTypes.toList());
              },
            ),
            CardPayment(
              label: context.i18n.debit,
              icon: PIcons.strokeRoundedCreditCard,
              value: store.paymentIsEnable(PaymentType.debit),
              onChanged: (value) {
                store.switchPaymentType(paymentType: PaymentType.debit, value: value);
              },
              orderTypes: store.getOrderTypesByPaymentType(PaymentType.debit).toSet(),
              onOrderTypeChanged: (orderTypes) {
                store.updateOrderTypesByPaymentType(paymentType: PaymentType.debit, orderTypes: orderTypes.toList());
              },
            ),
            if (isBr)
              PixCardComponent(
                onSave: (pixDto) async {
                  await store.savePixDto(pixDto);
                  if (context.mounted) {
                    toast.showSucess(context.i18n.alteracoesSalvas);
                  }
                },
                pixDto: store.paymentMethod.pixMetadata ?? PixMetadata(type: PixKeyType.cpf, key: "", receipientName: ""),
                store: store,
              ),
          ],
        );
      },
    );
  }
}
