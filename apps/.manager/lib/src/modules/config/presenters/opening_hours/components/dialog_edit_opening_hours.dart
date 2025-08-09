import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/dialogs/dialog_delete.dart';
import 'package:manager/src/core/components/tag_widget.dart';
import 'package:manager/src/modules/config/aplication/stores/opening_hours_store.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:ui/ui.dart';

class DialogEditOpeningHours extends StatefulWidget {
  final OpeningHoursModel model;
  final OpeningStore store;
  const DialogEditOpeningHours({required this.model, required this.store, super.key});

  @override
  State<DialogEditOpeningHours> createState() => _DialogEditOpeningHoursState();
}

class _DialogEditOpeningHoursState extends State<DialogEditOpeningHours> {
  late final openingEC = TextEditingController(text: widget.model.openingEnumValue.label);
  late final closingEC = TextEditingController(text: widget.model.closingEnumValue.label);
  late HoursEnum opening = widget.model.openingEnumValue;
  late HoursEnum closing = widget.model.closingEnumValue;

  @override
  void dispose() {
    openingEC.dispose();
    closingEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CwDialog(
      title: Text(context.i18n.editarHorarioFuncionamento),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      return;
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
                      return;
                    }
                  });
                },
              ),
            ],
          ),
          PSize.ii.sizedBoxH,
          TagWidget(label: widget.model.weekDayId.label.i18n().toUpperCase(), style: context.textTheme.labelLarge, onTap: () {}),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PButton(
                label: context.i18n.deletar,
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context) => DialogDelete(
                      onDelete: () async {
                        await widget.store.delete(widget.model);
                      },
                    ),
                  );
                },
                color: context.color.errorColor,
              ),
              PSize.iii.sizedBoxW,
              PButton(
                label: context.i18n.salvar,
                onPressedFuture: () async {
                  final nav = Navigator.of(context);
                  if (openingEC.text.isEmpty || closingEC.text.isEmpty) {
                    toast.showInfo(context.i18n.necessarioDefinirHorarios);
                    return;
                  }
                  await widget.store.update(model: widget.model, opening: opening, closing: closing);
                  nav.pop();
                  if (context.mounted) {
                    toast.showSucess(context.i18n.alteracoesSalvas);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
