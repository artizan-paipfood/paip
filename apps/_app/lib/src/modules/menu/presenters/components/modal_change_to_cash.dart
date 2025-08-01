import 'package:flutter/material.dart';

import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/modules/menu/presenters/view_models/menu_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ModalChangeToCash extends StatefulWidget {
  final MenuViewmodel store;

  const ModalChangeToCash({super.key, required this.store});

  @override
  State<ModalChangeToCash> createState() => _ModalChangeToCashState();
}

class _ModalChangeToCashState extends State<ModalChangeToCash> {
  final FocusNode focusNode = FocusNode();
  double changeTo = 0;

  void _submit() {
    if (changeTo > widget.store.orderViewmodel.order.getAmount) {
      widget.store.orderViewmodel.setOrder(widget.store.orderViewmodel.order.copyWith(changeTo: double.parse(changeTo.toStringAsFixed(2))));
    }
    context.pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return CwModal(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: PSize.iv.paddingBottom + PSize.ii.paddingHorizontal,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.i18n.vocePrecisaDeTroco, style: context.textTheme.titleSmall),
                Text(widget.store.orderViewmodel.getSubtotalMinusDiscounts.toStringCurrency, style: context.textTheme.titleSmall?.muted(context)),
                PSize.i.sizedBoxH,
                CwTextFormFild(
                  label: context.i18n.trocoP,
                  prefixText: "${context.i18n.currency} ",
                  maskUtils: MaskUtils.currency(),
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => changeTo = double.tryParse(value.replaceAll(",", ".")) ?? 0,
                  onFieldSubmitted: (value) => _submit(),
                ),
                PSize.v.sizedBoxH,
                Row(children: [Expanded(child: PButton(label: context.i18n.confirmar.toUpperCase(), onPressed: () => _submit()))]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
