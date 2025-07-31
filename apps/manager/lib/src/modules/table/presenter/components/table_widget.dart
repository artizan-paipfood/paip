import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';

import 'package:paipfood_package/paipfood_package.dart';

class TableWidget extends StatelessWidget {
  final TableModel table;
  final double? size;
  final void Function()? onTap;
  final bool isSelected;
  final BorderRadiusGeometry? borderRadius;
  final List<int> tableGroup;
  final bool isTableParent;

  const TableWidget({required this.table, this.isTableParent = false, this.tableGroup = const [], super.key, this.size, this.onTap, this.isSelected = false, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(borderRadius: borderRadius ?? 0.5.borderRadiusAll, color: table.status.color, border: Border.all(color: isSelected ? Colors.blue : context.color.neutral950, width: isSelected ? 4 : 1)),
        child: Stack(
          children: [
            if (table.capacity > 0) Positioned(top: 1, right: 1, child: Badge.count(count: table.capacity, backgroundColor: PColors.neutral_.shade500)),
            if (tableGroup.isNotEmpty) Positioned(bottom: 4, right: 1, child: Tooltip(message: '${context.i18n.agrupado}: ${tableGroup.map((e) => "$e").join(", ")}', child: Icon(PIcons.strokeRoundedLink01, color: isTableParent ? Colors.white : Colors.blueGrey, size: 20))),
            Center(child: Text(table.number.toString(), style: context.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
