import 'package:flutter/material.dart';
import 'package:manager/src/core/stores/layout_printer_store.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/ui_order_print.dart';

import 'package:paipfood_package/paipfood_package.dart';

class DialogPrinterOrder extends StatelessWidget {
  final OrderModel order;
  final int? tableNumber;
  const DialogPrinterOrder({
    required this.order,
    this.tableNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: PSize.ii.paddingAll,
      content: SingleChildScrollView(
        child: UiOrderPrint(order: order, tableNumber: tableNumber, layoutPrinterDto: LayoutPrinterStore.instance.layoutPrinters.first),
      ),
    );
  }
}
