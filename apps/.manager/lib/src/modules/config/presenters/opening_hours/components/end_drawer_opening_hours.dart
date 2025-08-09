import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/dialog_end_drawer.dart';
import 'package:manager/src/core/components/tag_widget.dart';
import 'package:manager/src/modules/config/aplication/stores/opening_hours_store.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:ui/ui.dart';

class EndDrawerOpeningHours extends StatefulWidget {
  const EndDrawerOpeningHours({super.key});

  @override
  State<EndDrawerOpeningHours> createState() => _EndDrawerOpeningHoursState();
}

class _EndDrawerOpeningHoursState extends State<EndDrawerOpeningHours> {
  late final store = context.read<OpeningStore>();
  List<WeekDayEnum> weekDays = [];
  final openingEC = TextEditingController();
  final closingEC = TextEditingController();
  HoursEnum opening = HoursEnum.am8;
  HoursEnum closing = HoursEnum.pm8;

  @override
  void dispose() {
    openingEC.dispose();
    closingEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CwDialogEndDrawer(
      child: Padding(
        padding: PSize.iii.paddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.i18n.horaioFuncionamento, style: context.textTheme.titleLarge),
            Text(context.i18n.descDefinirHorarios),
            PSize.v.sizedBoxH,
            Row(
              children: [
                PDropMenuForm<HoursEnum>(
                  labelText: context.i18n.abertura,
                  controller: openingEC,
                  dropdownMenuEntries: HoursEnum.values.map((e) => DropdownMenuEntry(value: e, label: e.label)).toList(),
                  onSelected: (value) {
                    setState(() {
                      final open = double.parse(Utils.onlyNumbersRgx(value?.label ?? "0"));
                      final close = double.tryParse(Utils.onlyNumbersRgx(closingEC.text)) ?? 100000;
                      opening = value ?? HoursEnum.am8;
                      if (closingEC.text.isNotEmpty && open > close) {
                        toast.showInfo(context.i18n.horarioAberturaDeveSerMenorQueHorarioFechamento);
                        closingEC.clear();
                      }
                    });
                  },
                ),
                PSize.ii.sizedBoxW,
                PDropMenuForm<HoursEnum>(
                  labelText: context.i18n.fechamento,
                  controller: closingEC,
                  dropdownMenuEntries: HoursEnum.values.where((element) => element.value > opening.value).map((e) => DropdownMenuEntry(value: e, label: e.label)).toList(),
                  onSelected: (value) {
                    setState(() {
                      final close = double.parse(Utils.onlyNumbersRgx(value?.label ?? "0"));
                      final open = double.tryParse(Utils.onlyNumbersRgx(openingEC.text)) ?? 100000;
                      closing = value ?? HoursEnum.pm8;
                      if (closingEC.text.isNotEmpty && open > close) {
                        toast.showInfo(context.i18n.horarioFechamentoDeveSerMaiorQueHorarioAbertura);
                        openingEC.clear();
                      }
                    });
                  },
                ),
              ],
            ),
            PSize.ii.sizedBoxH,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: WeekDayEnum.values
                  .map(
                    (e) => TagWidget(
                      isSelected: weekDays.contains(e),
                      label: e.label.i18n().toUpperCase(),
                      style: context.textTheme.labelLarge,
                      onTap: () {
                        setState(() {
                          if (weekDays.contains(e)) {
                            weekDays.remove(e);
                            return;
                          }
                          weekDays.add(e);
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PButton(
                  label: context.i18n.salvar,
                  onPressedFuture: () async {
                    final nav = Navigator.of(context);
                    if (openingEC.text.isEmpty || closingEC.text.isEmpty || weekDays.isEmpty) {
                      toast.showInfo(context.i18n.necessarioDefinirHorarios);
                      return;
                    }
                    await store.save(weekDays: weekDays, opening: opening, closing: closing);
                    nav.pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
