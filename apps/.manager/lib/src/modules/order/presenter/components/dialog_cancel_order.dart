import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/order/aplication/stores/order_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DialogCancelOrder extends StatefulWidget {
  final OrderModel order;
  final OrderStore store;
  const DialogCancelOrder({required this.order, required this.store, super.key});

  @override
  State<DialogCancelOrder> createState() => _DialogCancelOrderState();
}

class _DialogCancelOrderState extends State<DialogCancelOrder> {
  final formKey = GlobalKey<FormState>();
  String message = "";
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: CwDialog(
        title: Text("${context.i18n.cancelarPedido} #${widget.order.getOrderNumber}".toUpperCase()),
        content: CwTextFormFild(autofocus: true, maskUtils: MaskUtils.cRequired(), label: context.i18n.descrevaMotivoCancelamento, minLines: 2, maxLines: 2, hintText: context.i18n.acabouProdutoX('x'), onChanged: (value) => message = value),
        actions: [
          CwOutlineButton(
            label: context.i18n.cancelar.toUpperCase(),
            onPressed: () {
              context.pop();
            },
          ),
          PButton(
            label: context.i18n.confirmar.toUpperCase(),
            color: context.color.errorColor,
            onPressed: () async {
              if (formKey.currentState?.validate() ?? false) {
                context.pop();
                Loader.show(context);
                try {
                  await widget.store.cancelOrder(order: widget.order, message: message);
                } finally {
                  Loader.hide();
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
