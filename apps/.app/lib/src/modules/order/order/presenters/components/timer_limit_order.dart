import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/modules/order/order/aplication/stores/order_status_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class TimerLimitOrder extends StatefulWidget {
  final OrderStatusStore store;
  const TimerLimitOrder({super.key, required this.store});

  @override
  State<TimerLimitOrder> createState() => _TimerLimitOrderState();
}

class _TimerLimitOrderState extends State<TimerLimitOrder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 1)),
          builder: (context, snapshot) {
            final time = widget.store.order.timeLimitFormated;
            if (widget.store.order.status == OrderStatusEnum.losted) return const SizedBox.shrink();

            return Column(children: [Text(time ?? "00:00", textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge), Text(context.i18n.estabelecimentoTemEsteTempoParaAceitarSeuPedido(widget.store.establishment.fantasyName))]);
          },
        ),
      ],
    );
  }
}
