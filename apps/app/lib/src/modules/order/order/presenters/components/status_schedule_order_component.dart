import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/modules/menu/presenters/components/base_card_menu.dart';
import 'package:app/src/modules/order/order/aplication/stores/order_status_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class StatusScheduleOrderComponent extends StatelessWidget {
  final OrderStatusStore store;
  const StatusScheduleOrderComponent({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return BaseCardMenu(
      width: double.infinity,
      children: [
        Padding(
          padding: PSize.i.paddingHorizontal,
          child: Row(
            children: [
              SizedBox(child: DecoratedBox(decoration: BoxDecoration(borderRadius: 100.0.borderRadiusAll, color: context.color.neutral100), child: Padding(padding: const EdgeInsets.all(8.0), child: Icon(PIcons.strokeRoundedAlarmClock, color: context.color.primaryColor)))),
              PSize.i.sizedBoxW,
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(context.i18n.agendado, style: context.textTheme.bodyMedium?.muted(context)), Text(store.order.buildScheduleTimeIntervalFormated(context), style: context.textTheme.titleMedium)]),
            ],
          ),
        ),
      ],
    );
  }
}
