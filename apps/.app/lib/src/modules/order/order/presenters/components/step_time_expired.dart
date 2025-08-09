import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';

import 'package:app/src/modules/order/order/aplication/stores/order_status_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class StepTimeExpired extends StatelessWidget {
  final OrderStatusStore store;
  final OrderStatusEnum orderStatus;
  const StepTimeExpired({super.key, required this.store, required this.orderStatus});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PSize.ii.paddingHorizontal,
      child: Column(
        children: [
          Text(orderStatus == OrderStatusEnum.canceled ? context.i18n.pedidoCanceladoPeloEstabelecimento : context.i18n.tempoExpirado, style: context.textTheme.titleMedium),
          PSize.i.sizedBoxH,
          LinearProgressIndicator(color: context.color.errorColor, minHeight: 7, borderRadius: PSize.i.borderRadiusAll, value: 1),
          PSize.ii.sizedBoxH,
          if (orderStatus == OrderStatusEnum.losted && store.order.chargeId != null) //
            Text(store.order.isPaid == false ? context.i18n.naoSePreocupeExtornoSeuPagamento : context.i18n.entreContatoEstabelecimentoReembolso(store.establishment.phone)),
        ],
      ),
    );
  }
}
