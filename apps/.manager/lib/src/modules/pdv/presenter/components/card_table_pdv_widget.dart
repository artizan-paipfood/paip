import 'package:flutter/material.dart';
import 'package:manager/src/modules/table/presenter/components/table_widget.dart';

import 'package:paipfood_package/paipfood_package.dart';

class CardTablePdvWidget extends StatelessWidget {
  final TableModel table;
  final void Function() onDiscartTable;
  const CardTablePdvWidget({
    required this.table,
    required this.onDiscartTable,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 42,
          decoration: BoxDecoration(
            color: context.color.primaryColor,
            borderRadius: PSize.i.borderRadiusBottomLeft + PSize.i.borderRadiusTopLeft,
            border: Border.all(color: context.color.neutral950),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              PIcons.strokeRoundedTable02,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 80,
          child: TableWidget(
            table: table,
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        Material(
          color: context.color.errorColor,
          borderRadius: PSize.i.borderRadiusBottomRight + PSize.i.borderRadiusTopRight,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: onDiscartTable,
            child: Ink(
              height: 42,
              decoration: BoxDecoration(
                borderRadius: PSize.i.borderRadiusBottomRight + PSize.i.borderRadiusTopRight,
                border: Border.all(color: context.color.neutral950),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  PIcons.strokeRoundedCancel01,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
