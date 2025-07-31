import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/table/aplication/controllers/table_order_controller.dart';

import 'package:manager/src/modules/table/aplication/stores/table_store.dart';
import 'package:manager/src/modules/table/presenter/components/data_table_component.dart';
import 'package:manager/src/modules/table/presenter/components/table_widget.dart';
import 'package:paipfood_package/paipfood_package.dart';

class TableViewComponent extends StatefulWidget {
  final TableStore store;
  final TableOrderController controller;

  const TableViewComponent({required this.store, required this.controller, super.key});

  @override
  State<TableViewComponent> createState() => _TableViewComponentState();
}

class _TableViewComponentState extends State<TableViewComponent> {
  TableModel? _tableChild;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              SingleChildScrollView(child: Row(children: TableStatus.values.map((st) => Padding(padding: const EdgeInsets.only(right: 8), child: Row(children: [Icon(Icons.circle, color: st.color), Text(st.name.i18n())]))).toList())),
              Expanded(
                child: SingleChildScrollView(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      color: context.color.neutral200,
                      width: 90 * 20,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 20),
                        itemCount: 20 * 20,
                        itemBuilder: (context, index) {
                          final table = widget.store.getTableByPosition(index);
                          return Container(
                            width: 90,
                            height: 90,
                            margin: const EdgeInsets.all(1),
                            child: Padding(
                              padding: 0.5.paddingAll,
                              child: table != null
                                  ? TableWidget(
                                      tableGroup: widget.store.getTableGroup(table),
                                      isTableParent: widget.store.isTableParent(table.number),
                                      table: table,
                                      onTap: () async {
                                        Loader.show(context);
                                        final tableId = table.tableParentNumber ?? table.number;
                                        final tableResult = widget.store.getTableByNumber(tableId);
                                        if (tableResult!.number != table.number) {
                                          _tableChild = table;
                                        } else {
                                          _tableChild = null;
                                        }
                                        await widget.controller.loadOrdersByTable(tableResult);
                                        widget.store.setSelectedTable(tableResult);
                                        Loader.hide();
                                      },
                                      isSelected: table.number == widget.store.selectedTable?.number,
                                    )
                                  : const SizedBox(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: context.color.neutral50,
          width: 300,
          height: double.infinity,
          child: widget.store.selectedTable == null
              ? CwEmptyState(size: 100, label: context.i18n.selecioneUmaMesa, bgColor: false, icon: PIcons.strokeRoundedTable02)
              : Padding(
                  key: Key(widget.store.selectedTable!.number.toString()),
                  padding: PSize.i.paddingAll,
                  child: DataTableComponent(
                    table: widget.store.selectedTable!,
                    tableAreas: widget.store.tableAreas,
                    onSave: (table) => widget.store.updateTable(table),
                    onDelete: (table) => widget.store.deleteTable(table),
                    orders: widget.controller.getOrdersByTable(widget.store.selectedTable!),
                    store: widget.store,
                    tableChild: _tableChild,
                    onTurnTableToAvaliable: (table) {
                      widget.store.turnTableToAvaliable(table);
                      toast.showSucess(context.i18n.mesaXDisponivel(table.number));
                    },
                  ),
                ),
        ),
      ],
    );
  }
}
