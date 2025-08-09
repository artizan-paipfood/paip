import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/table/aplication/stores/table_store.dart';
import 'package:manager/src/modules/table/presenter/components/table_widget.dart';

import 'package:paipfood_package/paipfood_package.dart';

class DialogUnlinkTablesComponent extends StatefulWidget {
  final TableModel table;
  final void Function() onUnlink;
  const DialogUnlinkTablesComponent({required this.table, required this.onUnlink, super.key});

  @override
  State<DialogUnlinkTablesComponent> createState() => _DialogUnlinkTablesComponentState();
}

class _DialogUnlinkTablesComponentState extends State<DialogUnlinkTablesComponent> {
  late final tableStore = context.read<TableStore>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.i18n.separarMesas),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(children: [Expanded(child: TableWidget(table: widget.table, tableGroup: tableStore.getTableGroup(widget.table), isTableParent: tableStore.isTableParent(widget.table.number)))]),
          PSize.spacer.sizedBoxH,
          Row(
            children: [
              Expanded(
                child: PButton(
                  color: context.color.black,
                  colorText: context.color.white,
                  label: context.i18n.separar.toUpperCase(),
                  onPressed: () {
                    widget.onUnlink();
                  },
                ),
              ),
            ],
          ),
          PSize.spacer.sizedBoxH,
          Row(
            children: [
              Expanded(
                child: CwTextButton(
                  label: context.i18n.cancelar.toUpperCase(),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
