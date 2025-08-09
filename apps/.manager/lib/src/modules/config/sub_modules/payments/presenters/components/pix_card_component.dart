import 'package:flutter/material.dart';
import 'package:core/core.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/config/sub_modules/payments/presenters/viewmodels/payments_viewmodel.dart';
import 'package:manager/src/modules/config/sub_modules/payments/presenters/components/card_payment.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:ui/ui.dart';

class PixCardComponent extends StatefulWidget {
  final PaymentsViewmodel store;
  final PixMetadata pixDto;
  final void Function(PixMetadata pixDto) onSave;

  const PixCardComponent({required this.store, required this.pixDto, required this.onSave, super.key});

  @override
  State<PixCardComponent> createState() => _PixCardComponentState();
}

class _PixCardComponentState extends State<PixCardComponent> {
  late PixMetadata _pixDto = widget.pixDto;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: CardPayment(
        label: context.i18n.pix,
        icon: PIcons.strokeRoundedQrCode,
        value: widget.store.paymentIsEnable(PaymentType.pix),
        onChanged: (value) {
          if (_formKey.currentState!.validate()) {
            widget.store.switchPaymentType(paymentType: PaymentType.pix, value: value);
          }
        },
        orderTypes: widget.store.getOrderTypesByPaymentType(PaymentType.pix).toSet(),
        onOrderTypeChanged: (orderTypes) {
          widget.store.updateOrderTypesByPaymentType(paymentType: PaymentType.pix, orderTypes: orderTypes.toList());
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: PDropMenuForm<PixKeyType>(
                      labelText: "Tipo da chave",
                      initialSelection: widget.pixDto.type,
                      validator: (value) => value == null ? "Selecione o tipo da chave" : null,
                      dropdownMenuEntries: PixKeyType.values.map((e) => DropdownMenuEntry(value: e, label: e.label)).toList(),
                      onSelected: (pixEnum) {
                        _pixDto = _pixDto.copyWith(type: pixEnum);
                      },
                    ),
                  ),
                  PSize.ii.sizedBoxH,
                  Expanded(
                    child: CwTextFormFild(
                      label: "Chave PIX",
                      initialValue: widget.pixDto.key,
                      maskUtils: MaskUtils.cRequired(
                        customValidate: (value) {
                          if ((value?.length ?? 0) < 9) return "Chave PIX inválida";
                          return null;
                        },
                      ),
                      onChanged: (value) => _pixDto = _pixDto.copyWith(key: value),
                    ),
                  ),
                  PSize.ii.sizedBoxW,
                  Expanded(child: CwTextFormFild(initialValue: widget.pixDto.receipientName, label: "Nome do responsável", maskUtils: MaskUtils.cRequired(), onChanged: (value) => _pixDto = _pixDto.copyWith(receipientName: value))),
                  PSize.ii.sizedBoxW,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: PButton(
                label: context.i18n.salvar,
                onPressedFuture: () async {
                  if (_formKey.currentState!.validate()) {
                    widget.onSave(_pixDto);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
