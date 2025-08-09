import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/container_shadow.dart';
import 'package:manager/src/core/components/header_card.dart';
import 'package:manager/src/core/components/inner_container.dart';
import 'package:manager/src/modules/config/aplication/stores/opening_hours_store.dart';
import 'package:manager/src/modules/config/presenters/opening_hours/components/dialog_schedule_ajust_component.dart';
import 'package:manager/src/modules/config/presenters/opening_hours/components/end_drawer_opening_hours.dart';
import 'package:manager/src/modules/config/presenters/opening_hours/components/week_day_widget.dart';
import 'package:paipfood_package/paipfood_package.dart';

class OpeningHoursPage extends StatefulWidget {
  const OpeningHoursPage({super.key});

  @override
  State<OpeningHoursPage> createState() => _OpeningHoursPageState();
}

class _OpeningHoursPageState extends State<OpeningHoursPage> {
  late final store = context.read<OpeningStore>();
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        return Column(
          children: [
            Expanded(
              child: CwContainerShadow(
                child: Column(
                  children: [
                    CwHeaderCard(
                      titleLabel: context.i18n.horaioFuncionamento,
                      description: '${context.i18n.descHorariosFuncionamento}.',
                      actions: Row(
                        children: [
                          CwOutlineButton(
                            label: context.i18n.agendamentos,
                            icon: PIcons.strokeRoundedAlarmClock,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => DialogScheduleAjustComponent(
                                  establishment: store.establishment,
                                  onSave: (establishment) async {
                                    try {
                                      Loader.show(context);
                                      await store.updateEstablishment(establishment);
                                      if (context.mounted) {
                                        toast.showSucess(context.i18n.salvo);
                                      }
                                    } catch (e) {
                                      toast.showError(e.toString());
                                    } finally {
                                      Loader.hide();
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                          PSize.ii.sizedBoxW,
                          PButton(
                            label: context.i18n.adicionarHorario,
                            onPressed: () {
                              showDialog(context: context, builder: (context) => const EndDrawerOpeningHours());
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: CwInnerContainer(
                          width: double.infinity,
                          child: Column(
                            children: [
                              DecoratedBox(
                                decoration: BoxDecoration(borderRadius: PSize.i.borderRadiusAll, color: context.color.primaryBG),
                                child: ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Padding(
                                      padding: PSize.i.paddingAll,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(border: Border.all(color: context.color.neutral300), borderRadius: PSize.i.borderRadiusAll),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(width: 120, child: WeekDayWidget(label: "", showHours: true)),
                                            ...WeekDayEnum.values.map((e) => SizedBox(width: 120, child: WeekDayWidget(label: e.label.i18n().toUpperCase(), opingHours: store.openingHours.where((element) => element.weekDayId == e).toList()))),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
