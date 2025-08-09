import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';

class TableWidget extends StatelessWidget {
  final TableModel table;
  final double? size;
  final void Function()? onTap;
  final bool isSelected;

  const TableWidget({
    required this.table,
    super.key,
    this.size,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: 0.5.borderRadiusAll,
          color: context.color.neutral.shade400,
          border: Border.all(color: isSelected ? Colors.blue : context.color.neutral950, width: isSelected ? 4 : 1),
        ),
        child: Stack(
          children: [
            if (table.capacity > 0)
              Padding(
                padding: const EdgeInsets.only(right: 2, top: 2),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Badge.count(
                    count: table.capacity,
                    backgroundColor: PColors.neutral_.shade500,
                  ),
                ),
              ),
            Center(
                child: Text(
              table.number.toString(),
              style: context.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            )),
          ],
        ),
      ),
    );
  }
}
