import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';

import 'package:manager/src/modules/table/aplication/stores/table_store.dart';
import 'package:manager/src/modules/table/presenter/components/add_table_widget.dart';
import 'package:manager/src/modules/table/presenter/components/edit_table_component.dart';
import 'package:manager/src/modules/table/presenter/components/table_widget.dart';
import 'package:paipfood_package/paipfood_package.dart';

class TableConfigViewComponent extends StatelessWidget {
  final TableStore store;
  const TableConfigViewComponent({required this.store, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
                    final table = store.getTableByPosition(index);
                    return Container(
                      width: 90,
                      height: 90,
                      color: context.color.neutral100,
                      margin: const EdgeInsets.all(1),
                      child: Padding(
                        padding: 0.5.paddingAll,
                        child: table != null
                            ? Draggable<int>(
                                data: index,
                                feedback: Material(child: TableWidget(isTableParent: store.isTableParent(table.number), tableGroup: store.getTableGroup(table), table: table, size: 80)),
                                childWhenDragging: const SizedBox.shrink(),
                                child: TableWidget(isTableParent: store.isTableParent(table.number), tableGroup: store.getTableGroup(table), table: table, onTap: () => store.setSelectedTable(table), isSelected: table.number == store.selectedTable?.number),
                              )
                            : DragTarget<int>(
                                builder: (context, candidates, rejectedData) {
                                  if (candidates.isNotEmpty) {
                                    return DottedBorder(color: context.color.primaryColor, strokeCap: StrokeCap.round, strokeWidth: 2, radius: const Radius.circular(20), dashPattern: const [5, 5], child: Container(color: context.color.primaryColor.withOpacity(0.3)));
                                  }

                                  return AddTableWidget(
                                    onTap: () async {
                                      await store.addTable(index);
                                    },
                                  );
                                },
                                onAcceptWithDetails: (oldIndex) {
                                  store.changeTablePosition(oldIndex: oldIndex.data, newIndex: index);
                                },
                              ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Container(
          color: context.color.neutral50,
          width: 200,
          height: double.infinity,
          child: store.selectedTable == null
              ? CwEmptyState(size: 100, label: context.i18n.selecioneUmaMesa, bgColor: false, icon: PIcons.strokeRoundedTable02)
              : Padding(
                  key: Key(store.selectedTable!.number.toString()),
                  padding: PSize.i.paddingAll,
                  child: EditTableComponent(table: store.selectedTable!, tableAreas: store.tableAreas, onSave: (table) => store.updateTable(table), onDelete: (table) => store.deleteTable(table), store: store),
                ),
        ),
      ],
    );
  }
}
