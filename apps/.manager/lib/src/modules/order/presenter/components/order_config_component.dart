import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/menu/presenters/components/complements/switch_required_widget.dart';

import 'package:manager/src/modules/order/aplication/stores/order_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class OrderConfigComponent extends StatelessWidget {
  final OrderStore store;
  const OrderConfigComponent({required this.store, super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(8, 30),
      color: context.color.primaryBG,
      surfaceTintColor: Colors.transparent,
      constraints: const BoxConstraints(maxWidth: 500),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Row(
            children: [
              CwTextFormFild(label: context.i18n.tempoEntrega, expanded: true, suffixText: "min", initialValue: store.establishment.getTimesDelivery[0], maskUtils: MaskUtils.onlyInt(isRequired: true), onChanged: (value) => store.setDeliveryTime(initialTime: value)),
              PSize.i.sizedBoxW,
              CwTextFormFild(label: "", suffixText: "min", expanded: true, initialValue: store.establishment.getTimesDelivery[1], maskUtils: MaskUtils.onlyInt(isRequired: true), onChanged: (value) => store.setDeliveryTime(endTime: value)),
            ],
          ),
        ),
        PopupMenuItem(
          child: Row(
            children: [
              CwTextFormFild(expanded: true, label: context.i18n.tempoRetirada, initialValue: store.establishment.getTimesTakeway[0], suffixText: "min", maskUtils: MaskUtils.onlyInt(isRequired: true), onChanged: (value) => store.setTakewayTime(initialTime: value)),
              PSize.i.sizedBoxW,
              CwTextFormFild(label: "", expanded: true, suffixText: "min", initialValue: store.establishment.getTimesTakeway[1], maskUtils: MaskUtils.onlyInt(isRequired: true), onChanged: (value) => store.setTakewayTime(endTime: value)),
            ],
          ),
        ),
        PopupMenuItem(
          child: Padding(
            padding: 0.5.paddingVertical,
            child: Align(
              child: SwitchRequiredWidget(
                label: context.i18n.aceitarPedidosAutomaticamente,
                onChanged: (value) async {
                  Navigator.of(context).pop();
                  store.establishment.automaticAcceptOrders = value;
                  await store.updateEstablishment();
                },
                value: store.establishment.automaticAcceptOrders,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Expanded(
                child: PButton(
                  label: context.i18n.salvar,
                  onPressedFuture: () async {
                    Navigator.of(context).pop();
                    await store.updateEstablishment();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
      child: const Icon(PaipIcons.settings, size: 20),
    );
  }
}
