import 'package:flutter/material.dart';

import 'package:manager/src/core/services/printer/printer_dto.dart';
import 'package:manager/src/modules/config/presenters/printers/presenters/components/printer_search_bar_printer_component.dart';
import 'package:manager/src/modules/config/presenters/viewmodels/printer_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PrinterCard extends StatefulWidget {
  final PrinterDto printerDto;
  final Function(PrinterDto printerDto) onEdit;
  const PrinterCard({
    required this.printerDto,
    required this.onEdit,
    super.key,
  });

  @override
  State<PrinterCard> createState() => _PrinterCardState();
}

class _PrinterCardState extends State<PrinterCard> {
  late final viewmodel = context.read<PrinterViewmodel>();
  PrinterEntity get printer => widget.printerDto.printer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: PSize.i.borderRadiusAll,
            color: context.color.primaryBG,
          ),
          child: Padding(
            padding: PSize.i.paddingAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrinterSearchBarComponent(
                  savePrinter: (dto) {
                    widget.onEdit(dto);
                  },
                  printerDto: widget.printerDto,
                ),
                PSize.i.sizedBoxH,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
