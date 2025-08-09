import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:paipfood_package/paipfood_package.dart';

import 'package:pluto_grid/pluto_grid.dart';

class TableOrderReportsController {
  final BuildContext context;
  TableOrderReportsController({required this.context});

  late final PlutoGridStateManager stateManager;

  late final List<PlutoColumn> columns = [
    PlutoColumn(title: context.i18n.data, field: 'created_at', type: PlutoColumnType.date(format: 'dd/MM/yy HH:mm'), enableEditingMode: false, suppressedAutoSize: true),
    PlutoColumn(title: context.i18n.numero, field: 'order_number', type: PlutoColumnType.number(), enableEditingMode: false, footerRenderer: (rendererContext) => PlutoAggregateColumnFooter(rendererContext: rendererContext, type: PlutoAggregateColumnType.count)),
    PlutoColumn(title: context.i18n.nome, field: 'customer_name', type: PlutoColumnType.text(), enableEditingMode: false),
    PlutoColumn(title: context.i18n.orderType, field: 'order_type', type: PlutoColumnType.text(), enableEditingMode: false),
    PlutoColumn(title: context.i18n.status, field: 'order_status', type: PlutoColumnType.text(), enableEditingMode: false),
    PlutoColumn(title: context.i18n.formasPagamento, field: 'payment_method', type: PlutoColumnType.text(), enableEditingMode: false),
    PlutoColumn(title: context.i18n.taxaEntrega, field: 'delivery_tax', type: PlutoColumnType.number(), enableEditingMode: false, footerRenderer: (rendererContext) => PlutoAggregateColumnFooter(rendererContext: rendererContext, type: PlutoAggregateColumnType.sum)),
    PlutoColumn(
      title: context.i18n.desconto,
      field: 'discount',
      type: PlutoColumnType.number(),
      enableEditingMode: false,
      footerRenderer: (rendererContext) => PlutoAggregateColumnFooter(
        rendererContext: rendererContext,
        type: PlutoAggregateColumnType.sum,
        formatAsCurrency: true,
        titleSpanBuilder: (p0) => [const TextSpan(text: '- ', style: TextStyle(color: Colors.red)), TextSpan(text: p0, style: const TextStyle(color: Colors.red))],
      ),
      renderer: (rendererContext) {
        if (rendererContext.cell.value > 0) {
          return Text("- ${rendererContext.cell.value}", style: const TextStyle(color: Colors.red));
        }
        return const Text("-");
      },
    ),
    PlutoColumn(
      title: context.i18n.total,
      field: 'amount',
      type: PlutoColumnType.number(),
      // type: PlutoColumnType.number(format: 'R\$#,##0.00'),
      enableEditingMode: false,
      footerRenderer: (rendererContext) => PlutoAggregateColumnFooter(rendererContext: rendererContext, type: PlutoAggregateColumnType.sum),
    ),
    PlutoColumn(
      title: context.i18n.pago,
      field: 'is_paid',
      type: PlutoColumnType.number(),
      enableEditingMode: false,
      renderer: (rendererContext) {
        if (rendererContext.cell.value == 1) {
          return Text(context.i18n.pago, style: const TextStyle(color: Colors.green));
        }
        return const Text("-");
      },
    ),
    PlutoColumn(title: context.i18n.entregador, field: 'delivery_man', type: PlutoColumnType.text(), enableEditingMode: false),
  ];

  List<PlutoRow> buildRows({required List<OrderModel> orders, required List<DriverAndUserAdapter> drivers}) {
    final driversMap = drivers.groupListsBy((d) => d.user.id);
    return orders.where((o) => o.status != OrderStatusEnum.canceled && o.status != OrderStatusEnum.losted).map((order) {
      return PlutoRow(
        cells: {
          'created_at': PlutoCell(value: order.createdAt),
          'order_number': PlutoCell(value: order.orderNumber),
          'customer_name': PlutoCell(value: order.customer.name),
          'order_type': PlutoCell(value: order.orderType?.name.i18n()),
          'order_status': PlutoCell(value: order.status.name.i18n()),
          'payment_method': PlutoCell(value: order.paymentType?.name.i18n() ?? ' -- '),
          'discount': PlutoCell(value: order.discount),
          'amount': PlutoCell(value: order.amount),
          'delivery_tax': PlutoCell(value: order.deliveryTax),
          'is_paid': PlutoCell(value: order.isPaid),
          'delivery_man': PlutoCell(value: driversMap[order.driverId]?.first.user.name ?? "-"),
        },
      );
    }).toList();
  }
}
