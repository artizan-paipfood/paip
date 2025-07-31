import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/config/presenters/viewmodels/printer_viewmodel.dart';
import 'package:manager/src/modules/order/presenter/components/dialog_pdv.dart';
import 'package:manager/src/modules/pdv/aplication/stores/order_pdv_store.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/finish_order/card_order_resume_table_widget.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/finish_order/end_drawer_finish_order.dart';
import 'package:manager/src/modules/table/aplication/stores/table_store.dart';
import 'package:manager/src/modules/table/presenter/components/dialog_link_tables_component.dart';
import 'package:manager/src/modules/table/presenter/components/dialog_transfer_table_component.dart';
import 'package:manager/src/modules/table/presenter/components/dialog_unlink_tables_component.dart';
import 'package:manager/src/modules/table/presenter/components/table_widget.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DataTableComponent extends StatefulWidget {
  final TableModel table;
  final TableModel? tableChild;
  final TableStore store;
  final List<TableAreaModel> tableAreas;
  final Function(TableModel table) onSave;
  final Function(TableModel table) onDelete;
  final Function(TableModel table) onTurnTableToAvaliable;
  final List<OrderModel> orders;

  const DataTableComponent({required this.table, required this.store, required this.onSave, required this.onDelete, required this.onTurnTableToAvaliable, required this.orders, this.tableChild, super.key, this.tableAreas = const []});

  @override
  State<DataTableComponent> createState() => _DataTableComponentState();
}

class _DataTableComponentState extends State<DataTableComponent> {
  final formKey = GlobalKey<FormState>();
  late final orderPdvStore = context.read<OrderPdvStore>();
  late final printerViewmodel = context.read<PrinterViewmodel>();

  Future<void> _onCloseAccont(BuildContext context) async {
    Loader.show(context);
    final dto = await orderPdvStore.buildDto();
    Loader.hide();
    if (context.mounted) {
      await showDialog(context: context, builder: (context) => EndDrawerFinishOrder(dto: dto));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (widget.tableChild != null)
                Padding(padding: PSize.spacer.paddingRight, child: SizedBox(width: 80, child: TableWidget(table: widget.tableChild!, tableGroup: widget.store.getTableGroup(widget.tableChild!), isTableParent: widget.store.isTableParent(widget.tableChild!.number)))),
              Expanded(child: TableWidget(table: widget.table, tableGroup: widget.store.getTableGroup(widget.table), isTableParent: widget.store.isTableParent(widget.table.number))),
            ],
          ),
          PSize.ii.sizedBoxH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if ((widget.orders.isEmpty && widget.table.tableParentNumber == null) && widget.tableChild == null)
                IconButton(
                  tooltip: context.i18n.juntarMesas.toUpperCase(),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctxDialog) => DialogLinkTablesComponent(
                        table: widget.table,
                        onLink: (table2) async {
                          await widget.store.linkTables(widget.table, table2);
                          await widget.store.saveTables();
                          if (context.mounted) {
                            Navigator.pop(ctxDialog);
                          }
                        },
                      ),
                    );
                  },
                  icon: const Icon(PIcons.strokeRoundedLink01),
                ),
              if (widget.tableChild != null)
                IconButton(
                  tooltip: context.i18n.separarMesas.toUpperCase(),
                  icon: const Icon(PIcons.strokeRoundedUnlink03),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctxDialog) => DialogUnlinkTablesComponent(
                        table: widget.tableChild!,
                        onUnlink: () async {
                          await widget.store.separateTable(widget.tableChild!);
                          await widget.store.saveTables();
                          if (context.mounted) {
                            Navigator.pop(ctxDialog);
                          }
                        },
                      ),
                    );
                  },
                ),
              if (widget.orders.isNotEmpty && widget.table.status == TableStatus.occupied)
                IconButton(
                  tooltip: context.i18n.transferirMesa.toUpperCase(),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => DialogTransferTableComponent(
                        table: widget.table,
                        onTransfer: (tableTransfer) async {
                          Loader.show(context);
                          await widget.store.tranferTable(table: widget.table, transferTable: tableTransfer);
                          Loader.hide();
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                      ),
                    );
                  },
                  icon: const Icon(PIcons.strokeRoundedFolderTransfer),
                ),
              if (widget.orders.isEmpty && widget.table.status == TableStatus.occupied) IconButton(tooltip: context.i18n.limparMesa.toUpperCase(), onPressed: () => widget.onTurnTableToAvaliable(widget.table), icon: const Icon(PIcons.strokeRoundedClean)),
            ],
          ),
          PSize.spacer.sizedBoxH,

          PSize.i.sizedBoxH,
          Padding(padding: PSize.i.paddingVertical, child: Row(children: [Icon(Icons.circle, color: widget.table.status.color), PSize.i.sizedBoxW, Expanded(child: Text(widget.table.status.name.i18n(), style: context.textTheme.titleMedium))])),

          PSize.spacer.sizedBoxH,
          Text(context.i18n.pedidos, style: context.textTheme.titleMedium),
          // PSize.i.sizedBoxH,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...widget.orders.map(
                    (e) => Padding(
                      padding: 0.5.paddingBottom,
                      child: CardOrderResumeTableWidget(
                        order: e,
                        backGroundColor: context.isDarkTheme ? context.color.neutral200 : null,
                        actionWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            PSize.i.sizedBoxW,
                            IconButton(
                              onPressed: () {
                                printerViewmodel.printUnique(order: e, printerDto: printerViewmodel.printersInUse.first);
                              },
                              icon: const Icon(PIcons.strokeRoundedPrinter),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  PSize.iv.sizedBoxH,
                ],
              ),
            ),
          ),

          Padding(
            padding: PSize.i.paddingBottom,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: PButton(
                        label: context.i18n.adicionarItens.toUpperCase(),
                        icon: PIcons.strokeRoundedCashier,
                        onPressed: () async {
                          await showDialog(context: context, builder: (context) => const DialogPdv());
                        },
                      ),
                    ),
                  ],
                ),
                PSize.i.sizedBoxH,
                if (widget.orders.isNotEmpty)
                  Row(children: [Expanded(child: PButton(label: context.i18n.fecharConta.toUpperCase(), icon: PIcons.strokeRoundedDollar02, onPressed: () async => await _onCloseAccont(context), color: context.color.black, colorText: context.color.white))]),
              ],
            ),
          ),
        ],
      ).animate().shimmer(),
    );
  }
}
