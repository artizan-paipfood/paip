import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manager/l10n/i18n_extension.dart';

import 'package:manager/src/modules/table/aplication/stores/table_store.dart';
import 'package:manager/src/modules/table/presenter/components/table_widget.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:ui/ui.dart';

class EditTableComponent extends StatefulWidget {
  final TableModel table;
  final TableStore store;
  final List<TableAreaModel> tableAreas;
  final Function(TableModel table) onSave;
  final Function(TableModel table) onDelete;
  const EditTableComponent({required this.table, required this.store, required this.onSave, required this.onDelete, super.key, this.tableAreas = const []});

  @override
  State<EditTableComponent> createState() => _EditTableComponentState();
}

class _EditTableComponentState extends State<EditTableComponent> {
  late TableModel _tableAreaModel = widget.table.copyWith();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TableWidget(table: widget.table, isTableParent: widget.store.isTableParent(widget.table.number), tableGroup: widget.store.getTableGroup(widget.table)),
          PSize.ii.sizedBoxH,
          CwTextFormFild(
            label: context.i18n.numero,
            initialValue: widget.table.number.toString(),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maskUtils: MaskUtils.cRequired(
              customValidate: (value) {
                if (value == null || value.isEmpty) return context.i18n.numeroObrigatorio;
                final number = int.tryParse(value) ?? 0;
                if (number == 0) return context.i18n.numeroInvalido;
                if (number != widget.table.number && widget.store.existsTableByNumber(number)) return "$number ${context.i18n.jaExiste}";
                return null;
              },
            ),
            onChanged: (value) {
              _tableAreaModel = _tableAreaModel.copyWith(number: int.tryParse(value) ?? 0);
            },
          ),
          CwTextFormFild(
            label: context.i18n.capacidade,
            initialValue: widget.table.capacity.toString(),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maskUtils: MaskUtils.cRequired(),
            onChanged: (value) {
              _tableAreaModel = _tableAreaModel.copyWith(capacity: int.tryParse(value) ?? 0);
            },
          ),
          PDropMenuForm<TableAreaModel>(
            labelText: context.i18n.ambiente,
            initialSelection: widget.tableAreas.firstWhereOrNull((t) => t.id == widget.table.tableAreaId),
            isExpanded: true,
            dropdownMenuEntries: widget.tableAreas.map((t) => DropdownMenuEntry(value: t, label: t.name)).toList(),
            onSelected: (ambient) {
              _tableAreaModel = _tableAreaModel.copyWith(tableAreaId: ambient!.id);
            },
          ),
          PSize.ii.sizedBoxH,
          Row(children: [Expanded(child: PButton(label: context.i18n.excluirMesa, color: context.color.errorColor, onPressed: () => widget.onDelete(widget.table)))]),
          PSize.ii.sizedBoxH,
          Row(
            children: [
              Expanded(
                child: PButton(
                  label: context.i18n.salvar.toUpperCase(),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      widget.onSave(_tableAreaModel);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ).animate().shimmer(),
    );
  }
}
