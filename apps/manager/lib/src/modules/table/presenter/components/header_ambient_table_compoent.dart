import 'dart:async';

import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';

import 'package:manager/src/core/components/dialogs/dialog_delete.dart';
import 'package:manager/src/modules/table/presenter/components/dialog_add_table_area_component.dart';
import 'package:manager/src/modules/table/presenter/components/p_toggle_nivel_widget.dart';
import 'package:paipfood_package/paipfood_package.dart';

class HeaderAmbientTableCompoent extends StatefulWidget {
  final List<TableAreaModel> tableAreas;
  final TableAreaModel? selectedTableArea;
  final void Function(TableAreaModel tableArea) onTapTableArea;
  final FutureOr Function(TableAreaModel tableArea)? addTableArea;
  final FutureOr Function(TableAreaModel tableArea)? deleteTableArea;
  final Widget? action;
  const HeaderAmbientTableCompoent({required this.onTapTableArea, super.key, this.tableAreas = const [], this.selectedTableArea, this.addTableArea, this.deleteTableArea, this.action});

  @override
  State<HeaderAmbientTableCompoent> createState() => _HeaderAmbientTableCompoentState();
}

class _HeaderAmbientTableCompoentState extends State<HeaderAmbientTableCompoent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: PColors.light.neutral800,
      width: double.infinity,
      child: Padding(
        padding: PSize.i.paddingHorizontal + PSize.ii.paddingTop,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: widget.tableAreas.map((e) => Padding(padding: const EdgeInsets.only(right: 8), child: PToggleNivelWidget(isSelected: e == widget.selectedTableArea, label: e.name, onTap: () => widget.onTapTableArea(e)))).toList()),
              ),
            ),
            PSize.ii.sizedBoxW,
            if (widget.addTableArea != null)
              CwTextButton(
                colorText: Colors.white,
                icon: PIcons.strokeRoundedAdd01,
                label: context.i18n.adicionarAmbiente,
                onPressed: () {
                  showDialog(context: context, builder: (context) => DialogAddTableAreaComponent(addTableArea: widget.addTableArea));
                },
              ),
            if (widget.tableAreas.length > 1 && widget.deleteTableArea != null)
              IconButton(
                onPressed: () {
                  showDialog(context: context, builder: (context) => DialogDelete(content: Text('${context.i18n.area}: ${widget.selectedTableArea!.name}'), onDelete: () async => widget.deleteTableArea?.call(widget.selectedTableArea!)));
                },
                icon: const Icon(PIcons.strokeRoundedDelete02, color: Colors.white),
              ),
            widget.action ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
