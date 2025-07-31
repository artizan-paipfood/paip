import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/table/aplication/stores/table_store.dart';
import 'package:manager/src/modules/table/presenter/components/table_widget.dart';

import 'package:paipfood_package/paipfood_package.dart';

class DialogTransferTableComponent extends StatefulWidget {
  final TableModel table;
  final Function(TableModel tableTransfer) onTransfer;
  const DialogTransferTableComponent({required this.table, required this.onTransfer, super.key});

  @override
  State<DialogTransferTableComponent> createState() => _DialogTransferTableComponentState();
}

class _DialogTransferTableComponentState extends State<DialogTransferTableComponent> {
  late final tableStore = context.read<TableStore>();
  final ValueNotifier<TableModel?> _tableTransfer = ValueNotifier(null);
  List<int> get group => tableStore.getTableGroup(widget.table);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.i18n.transferirMesa),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(width: 120, child: TableWidget(table: widget.table, tableGroup: group, isTableParent: tableStore.isTableParent(widget.table.number))),
              PSize.i.sizedBoxW,
              const Icon(PIcons.strokeRoundedFolderTransfer),
              PSize.i.sizedBoxW,
              SizedBox(
                width: 120,
                child: ValueListenableBuilder(
                  valueListenable: _tableTransfer,
                  builder: (context, value, child) {
                    if (value == null) return const SizedBox.shrink();
                    return TableWidget(table: value, tableGroup: tableStore.getTableGroup(value), isTableParent: tableStore.isTableParent(value.number)).animate().shake();
                  },
                ),
              ),
            ],
          ),
          PSize.i.sizedBoxW,
          CwTextFormFild(
            label: context.i18n.numeroMesa,
            maskUtils: MaskUtils.onlyInt(),
            onChanged: (value) {
              if (value.isEmpty) {
                _tableTransfer.value = null;
                return;
              }
              final number = int.tryParse(value);
              if (group.any((n) => n == number)) return;
              if (number == widget.table.number) {
                _tableTransfer.value = null;
                return;
              }
              _tableTransfer.value = tableStore.getTableByNumber(int.parse(value));
            },
          ),
          PSize.i.sizedBoxH,
          ValueListenableBuilder(
            valueListenable: _tableTransfer,
            builder: (context, table, _) {
              if (table == null) return const SizedBox.shrink();
              return Row(
                children: [
                  Expanded(
                    child: PButton(
                      label: context.i18n.transferir.toUpperCase(),
                      onPressed: () {
                        widget.onTransfer(_tableTransfer.value!);
                      },
                    ),
                  ),
                ],
              ).animate().shimmer();
            },
          ),
        ],
      ),
    );
  }
}
