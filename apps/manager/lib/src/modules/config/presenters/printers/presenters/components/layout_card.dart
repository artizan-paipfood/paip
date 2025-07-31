import 'package:flutter/material.dart';

import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/layout_printer_dto.dart';
import 'package:paipfood_package/paipfood_package.dart';

class LayoutCard extends StatelessWidget {
  final LayoutPrinterDto layoutPrinterDto;
  final void Function()? onEdit;
  final void Function()? onDelete;
  const LayoutCard({
    required this.layoutPrinterDto,
    super.key,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Ink(
        height: 55,
        decoration: BoxDecoration(
            border: Border.all(
              color: context.color.border,
            ),
            borderRadius: PSize.i.borderRadiusAll),
        child: Padding(
          padding: PSize.i.paddingAll,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PSize.spacer.sizedBoxW,
              Text(layoutPrinterDto.layoutPrinter.name),
              PSize.spacer.sizedBoxW,
              if (layoutPrinterDto.layoutPrinter.isDefault == false) ...[
                IconButton(
                  onPressed: onEdit,
                  style: IconButton.styleFrom(backgroundColor: context.color.border.withOpacity(.4)),
                  icon: Icon(PIcons.strokeRoundedEdit02, size: 18),
                ),
                PSize.spacer.sizedBoxW,
                IconButton(
                  onPressed: onDelete,
                  style: IconButton.styleFrom(backgroundColor: context.color.errorColor.withOpacity(.1)),
                  icon: Icon(
                    PIcons.strokeRoundedDelete01,
                    size: 18,
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
