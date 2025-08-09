import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/config/presenters/preferences/components/card_switch.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DialogScheduleAjustComponent extends StatefulWidget {
  final EstablishmentModel establishment;
  final void Function(EstablishmentModel establishment) onSave;
  const DialogScheduleAjustComponent({required this.establishment, required this.onSave, super.key});

  @override
  State<DialogScheduleAjustComponent> createState() => _DialogScheduleAjustComponentState();
}

class _DialogScheduleAjustComponentState extends State<DialogScheduleAjustComponent> {
  late EstablishmentModel _establishment = widget.establishment.copyWith();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(context.i18n.ajustes), IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(PIcons.strokeRoundedCancel01))]),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CardSwitch(
            onChanged: (value) {
              setState(() {
                _establishment = _establishment.copyWith(enableSchedule: value);
              });
            },
            value: _establishment.enableSchedule,
            label: context.i18n.habilitarAgendamentos,
          ),
          CardSwitch(
            onChanged: (value) {
              setState(() {
                _establishment = _establishment.copyWith(enableScheduleTomorrow: value);
              });
            },
            value: _establishment.enableScheduleTomorrow,
            label: context.i18n.habilitarAgendamentosAmanha,
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: PButton(
                label: context.i18n.salvar.toUpperCase(),
                onPressed: () {
                  widget.onSave(_establishment);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
