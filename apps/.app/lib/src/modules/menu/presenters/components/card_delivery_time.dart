import 'package:flutter/material.dart';

import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/modules/menu/presenters/view_models/menu_viewmodel.dart';
import 'package:app/src/modules/menu/presenters/components/base_card_menu.dart';
import 'package:app/src/modules/menu/presenters/components/card_delivery_time_schedule_widget.dart';
import 'package:app/src/modules/menu/presenters/components/card_delivery_time_standard_widget.dart';
import 'package:app/src/modules/menu/presenters/components/scheduling/modal_scheadule_component.dart';
import 'package:app/src/modules/user/presenters/viewmodels/user_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardDeliveryTime extends StatefulWidget {
  final MenuViewmodel store;
  const CardDeliveryTime({super.key, required this.store});

  @override
  State<CardDeliveryTime> createState() => _CardDeliveryTimeState();
}

class _CardDeliveryTimeState extends State<CardDeliveryTime> {
  late final userStore = context.read<UserStore>();
  @override
  Widget build(BuildContext context) {
    return BaseCardMenu(
      children: [
        Text(context.i18n.tempoEstimado, style: context.textTheme.titleMedium),
        PSize.i.sizedBoxH,
        Padding(
          padding: PSize.i.paddingHorizontal,
          child: Row(
            children: [
              CardDeliveryTimeStandardWidget(store: widget.store, onTap: () => widget.store.orderViewmodel.unsetShedule(), isSelected: widget.store.orderViewmodel.order.isNotScheduling),
              PSize.i.sizedBoxW,
              CardDeliveryTimeScheduleWidget(
                store: widget.store,
                onTap: () async {
                  final result = await showModalBottomSheet(isScrollControlled: true, context: context, builder: (context) => ModalScheaduleComponent(store: widget.store));
                  if (result == null) widget.store.orderViewmodel.unsetShedule();
                },
                isSelected: widget.store.orderViewmodel.order.isScheduling,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
