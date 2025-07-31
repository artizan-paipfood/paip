import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/stores/orders_store.dart';
import 'package:manager/src/core/components/base_page.dart';
import 'package:manager/src/core/components/header_card.dart';
import 'package:manager/src/modules/reports/aplication/controllers/table_order_reports_controller.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:pluto_grid/pluto_grid.dart';

class OrderReportsPage extends StatefulWidget {
  const OrderReportsPage({super.key});

  @override
  State<OrderReportsPage> createState() => _OrderReportsPageState();
}

class _OrderReportsPageState extends State<OrderReportsPage> {
  late final tableController = TableOrderReportsController(context: context);
  late final dataSource = context.read<DataSource>();
  @override
  Widget build(BuildContext context) {
    return BasePage(
      header: CwHeaderCard(titleLabel: context.i18n.relatorioPedidos),
      child: PlutoGrid(
        rowColorCallback: (rowColorContext) {
          return rowColorContext.rowIdx % 2 == 0 ? context.color.neutral50 : (context.isDarkTheme ? context.color.neutral200 : context.color.neutral100);
        },
        columns: tableController.columns,
        rows: tableController.buildRows(orders: OrdersStore.instance.orders, drivers: dataSource.deliveryMen.values.toList()),
        onLoaded: (event) {
          tableController.stateManager = event.stateManager;
          tableController.stateManager.setShowColumnFilter(true);
        },
        onRowDoubleTap: (event) {
          // log(event.rowIdx.toString());
        },
        onRowSecondaryTap: (event) {
          log(event.rowIdx.toString());
        },
        configuration: PlutoGridConfiguration(
          localeText: isBr ? const PlutoGridLocaleText.brazilianPortuguese() : const PlutoGridLocaleText(),
          style: context.isDarkTheme ? PlutoGridStyleConfig.dark(gridBorderRadius: PSize.i.borderRadiusAll) : PlutoGridStyleConfig(gridBorderRadius: PSize.i.borderRadiusAll),
        ),
      ),
    );
  }
}
