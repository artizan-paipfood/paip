import 'package:flutter/material.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/layout_printer_dto.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/sections/section_cart.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/sections/section_spacer.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/sections/section_text.dart';
import 'package:paipfood_package/paipfood_package.dart' hide Path;

class UiOrderPrint extends StatefulWidget {
  final OrderModel order;
  final double numberColumns;
  final int? tableNumber;
  final LayoutPrinterDto layoutPrinterDto;

  const UiOrderPrint({
    required this.order,
    required this.tableNumber,
    required this.layoutPrinterDto,
    this.numberColumns = 330,
    super.key,
  });

  @override
  State<UiOrderPrint> createState() => _UiOrderPrintState();
}

class _UiOrderPrintState extends State<UiOrderPrint> {
  OrderModel get order => widget.order;

  // int _makeDivisibleBy8(int number) {
  //   if (number % 8 == 0) {
  //     return number;
  //   }
  //   return number + (8 - (number % 8));
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,

      // width: _makeDivisibleBy8(widget.numberColumns.toInt()).toDouble(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...widget.layoutPrinterDto.sections.map((e) {
            if (e is SectionText) {
              return e.build(
                context,
                order: order,
              );
            }
            if (e is SectionSpacer) {
              return e.build(context);
            }
            if (e is SectionCart) {
              return e.build(context, cartProducts: order.cartProducts);
            }
            return e.build(context);
          })
        ],
      ),
    );
  }
}
