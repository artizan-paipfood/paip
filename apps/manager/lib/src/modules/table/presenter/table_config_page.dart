import 'package:flutter/material.dart';

import 'package:manager/src/modules/table/aplication/stores/order_command_store.dart';
import 'package:manager/src/modules/table/aplication/stores/table_store.dart';
import 'package:manager/src/modules/table/presenter/components/header_ambient_table_compoent.dart';
import 'package:manager/src/modules/table/presenter/components/order_command_config_view_component.dart';
import 'package:manager/src/modules/table/presenter/components/header_table_and_order_comand_component.dart';
import 'package:manager/src/modules/table/presenter/components/table_config_view_component.dart';
import 'package:paipfood_package/paipfood_package.dart';

class TableConfigPage extends StatefulWidget {
  const TableConfigPage({super.key});

  @override
  State<TableConfigPage> createState() => _TableConfigPageState();
}

class _TableConfigPageState extends State<TableConfigPage> {
  late final store = context.read<TableStore>();
  late final storeOrderSheet = context.read<OrderCommandStore>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        try {
          Loader.show(context);
          await store.saveTables();
          await storeOrderSheet.save();
        } finally {
          Loader.hide();
        }
      },
      child: ListenableBuilder(
          listenable: store,
          builder: (context, _) {
            return Scaffold(
              backgroundColor: context.color.white,
              body: Column(
                children: [
                  HeaderTableAndOrderComponent(
                    isTableView: store.isTableView,
                    onTapCommand: () {
                      store.toggleOnView(false);
                    },
                    onTapTables: () {
                      store.toggleOnView(true);
                    },
                  ),
                  if (store.isTableView)
                    HeaderAmbientTableCompoent(
                      tableAreas: store.tableAreas,
                      selectedTableArea: store.selectedTableArea,
                      deleteTableArea: (tableArea) async {
                        Loader.show(context);
                        await store.deleteTableArea(tableArea);
                        Loader.hide();
                      },
                      onTapTableArea: (tableArea) => store.setSelectedTableArea(tableArea),
                      addTableArea: (tableArea) async {
                        Loader.show(context);
                        await store.addTableArea(tableArea);
                        Loader.hide();
                      },
                    ),
                  Expanded(
                    child: Padding(padding: const EdgeInsets.all(8.0), child: store.isTableView ? TableConfigViewComponent(store: store) : OrderCommandConfigViewComponent(store: storeOrderSheet)),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
