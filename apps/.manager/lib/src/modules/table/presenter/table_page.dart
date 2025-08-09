import 'package:flutter/material.dart';

import 'package:manager/src/core/components/dialog_end_drawer.dart';
import 'package:manager/src/modules/table/aplication/controllers/table_order_controller.dart';
import 'package:manager/src/modules/table/aplication/stores/table_store.dart';
import 'package:manager/src/modules/table/presenter/components/header_ambient_table_compoent.dart';
import 'package:manager/src/modules/table/presenter/components/table_view_component.dart';
import 'package:manager/src/modules/table/presenter/table_config_page.dart';
import 'package:paipfood_package/paipfood_package.dart';

class TablePage extends StatefulWidget {
  final TableStore store;
  const TablePage({
    required this.store,
    super.key,
  });

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  late final controller = context.read<TableOrderController>();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: widget.store,
        builder: (context, _) {
          return Scaffold(
            backgroundColor: context.color.white,
            body: Column(
              children: [
                HeaderAmbientTableCompoent(
                  onTapTableArea: (tableArea) {
                    widget.store.setSelectedTableArea(tableArea);
                  },
                  selectedTableArea: widget.store.selectedTableArea,
                  tableAreas: widget.store.tableAreas,
                  action: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            showDialog(context: context, builder: (context) => const CwDialogEndDrawer(widthFactor: 0.8, child: TableConfigPage()));
                          },
                          icon: const Icon(
                            PIcons.strokeRoundedSettings01,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TableViewComponent(store: widget.store, controller: controller),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
