import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/table/aplication/stores/table_store.dart';
import 'package:manager/src/modules/table/presenter/components/table_widget.dart';

import 'package:paipfood_package/paipfood_package.dart';

class DialogLinkTablesComponent extends StatefulWidget {
  final TableModel table;
  final void Function(TableModel table2) onLink;
  const DialogLinkTablesComponent({required this.table, required this.onLink, super.key});

  @override
  State<DialogLinkTablesComponent> createState() => _DialogLinkTablesComponentState();
}

class _DialogLinkTablesComponentState extends State<DialogLinkTablesComponent> {
  late final tableStore = context.read<TableStore>();
  final ValueNotifier<TableModel?> _tableLink = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.i18n.juntarMesas),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(width: 120, child: TableWidget(table: widget.table, tableGroup: tableStore.getTableGroup(widget.table), isTableParent: tableStore.isTableParent(widget.table.number))),
              PSize.i.sizedBoxW,
              const Icon(PIcons.strokeRoundedLink01),
              PSize.i.sizedBoxW,
              SizedBox(
                width: 120,
                child: ValueListenableBuilder(
                  valueListenable: _tableLink,
                  builder: (context, value, child) {
                    if (value == null) return const SizedBox.shrink();
                    return TableWidget(table: value, isTableParent: tableStore.isTableParent(value.number), tableGroup: tableStore.getTableGroup(value)).animate().shake();
                  },
                ),
              ),
            ],
          ),
          PSize.i.sizedBoxW,
          CwTextFormFild(
            key: UniqueKey(),
            label: context.i18n.numeroMesa,
            maskUtils: MaskUtils.onlyInt(),
            onChanged: (value) {
              if (value.isEmpty) {
                _tableLink.value = null;
                return;
              }
              final number = int.tryParse(value);
              if (number == widget.table.number) {
                _tableLink.value = null;
                return;
              }
              _tableLink.value = tableStore.getTableByNumber(int.parse(value));
            },
          ),
          PSize.i.sizedBoxH,
          ValueListenableBuilder(
            valueListenable: _tableLink,
            builder: (context, table, _) {
              if (table == null) return const SizedBox.shrink();
              return Row(
                children: [
                  Expanded(
                    child: PButton(
                      label: context.i18n.confirmar.toUpperCase(),
                      onPressed: () {
                        widget.onLink(_tableLink.value!);
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
