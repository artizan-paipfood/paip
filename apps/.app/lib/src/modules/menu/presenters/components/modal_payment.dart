import 'package:flutter/material.dart';

import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/modules/menu/domain/services/payment_service.dart';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ModalPayment extends StatefulWidget {
  const ModalPayment({super.key});

  @override
  State<ModalPayment> createState() => _ModalPaymentState();
}

class _ModalPaymentState extends State<ModalPayment> {
  bool _isSelected = false;
  late final service = context.read<PaymentService>();
  @override
  Widget build(BuildContext context) {
    return CwModal(
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: PSize.iv.paddingBottom,
          child: Column(
            children: [
              Text(context.i18n.comoDesejaPagar, style: context.textTheme.titleMedium),
              PSize.ii.sizedBoxH,
              ...service.paymentTypes.map((payment) {
                return _buildRow(
                  payment: payment,
                  onTap: () async {
                    if (_isSelected) return;
                    _isSelected = true;
                    await service.onPay(context, paymentType: payment);
                    _isSelected = false;
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow({required PaymentType payment, required void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 50),
        child: Padding(padding: PSize.i.paddingVertical + PSize.iv.paddingHorizontal, child: Row(children: [Icon(payment.icon), PSize.ii.sizedBoxW, Text(payment.name.i18n(), style: context.textTheme.bodyMedium?.muted(context))])),
      ),
    );
  }
}
