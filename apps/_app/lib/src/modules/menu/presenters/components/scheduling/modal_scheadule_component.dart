import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/modules/menu/presenters/view_models/menu_viewmodel.dart';
import 'package:app/src/modules/menu/presenters/components/scheduling/scheduling_controller.dart';
import 'package:app/src/modules/menu/presenters/components/scheduling/tab_bar_schedule_component.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ModalScheaduleComponent extends StatefulWidget {
  final MenuViewmodel store;

  const ModalScheaduleComponent({super.key, required this.store});

  @override
  State<ModalScheaduleComponent> createState() => _ModalScheaduleComponentState();
}

class _ModalScheaduleComponentState extends State<ModalScheaduleComponent> {
  final openingEC = TextEditingController();
  HoursEnum? _selectedTime;
  int _weekDay = DateTime.now().weekday;
  late final scheduleController = SchedulingController(establishment: widget.store.establishment, openingHours: widget.store.dataEstablishment.openingHours);

  @override
  Widget build(BuildContext context) {
    return CwModal(
      child: ListenableBuilder(
        listenable: widget.store,
        builder: (context, _) {
          return Padding(
            padding: PSize.iv.paddingBottom + PSize.ii.paddingHorizontal,
            child: Column(
              children: [
                Text(context.i18n.selecioneUmHorario.toUpperCase(), style: context.textTheme.titleMedium),
                PSize.ii.sizedBoxH,
                TabBarScheaduleComponent(
                  controller: scheduleController,
                  weekDay: _weekDay,
                  onSelect: (hour) {
                    setState(() {
                      _selectedTime = hour;
                    });
                  },
                  onSelectWeekDay: (weekDay) {
                    setState(() {
                      _weekDay = weekDay;
                    });
                  },
                  hourSelected: _selectedTime,
                ),
                PSize.iv.sizedBoxH,
                Row(
                  children: [
                    Expanded(
                      child: PButton(
                        label: context.i18n.confimarAgendamento.toUpperCase(),
                        onPressed: () {
                          if (_selectedTime != null) {
                            widget.store.orderViewmodel.setSchedule(hour: _selectedTime!, weekDay: _weekDay);
                            context.pop(true);
                            return;
                          }
                          context.pop();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
