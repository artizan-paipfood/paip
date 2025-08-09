import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';

import 'package:app/src/modules/order/order/aplication/stores/order_status_store.dart';
import 'package:app/src/modules/order/order/presenters/components/step_bar.dart';
import 'package:app/src/modules/order/order/presenters/components/timer_limit_order.dart';
import 'package:paipfood_package/paipfood_package.dart';

class StepWaiting extends StatelessWidget {
  final OrderStatusStore store;

  const StepWaiting({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PSize.ii.paddingHorizontal,
      child: Column(
        children: [
          StepBar(currentStep: store.currentSetEP, steps: [context.i18n.aguarandoAprovacaoRestaurante, context.i18n.preparando, (store.order.orderType == OrderTypeEnum.delivery ? context.i18n.saiuParaEntrega : context.i18n.aguardandoRetirada), context.i18n.entregue]),
          PSize.ii.sizedBoxH,
          if (store.order.status == OrderStatusEnum.pending) TimerLimitOrder(store: store),
        ],
      ),
    );
  }
}
