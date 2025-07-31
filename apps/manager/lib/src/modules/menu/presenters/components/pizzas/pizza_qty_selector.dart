import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PizzaQtySelector extends StatelessWidget {
  final QtyFlavorsPizza qty;
  final bool isSelected;
  final void Function(QtyFlavorsPizza value) onTap;
  const PizzaQtySelector({
    required this.qty, required this.onTap, super.key,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Material(
        elevation: 2,
        borderRadius: 100.0.borderRadiusAll,
        color: isSelected ? PColors.light.primaryColor : context.color.secondaryText,
        child: InkWell(
          onTap: () => onTap(qty),
          borderRadius: 100.0.borderRadiusAll,
          child: Ink(
            height: 30,
            width: 30,
            child: Center(
              child: Text(
                "${qty.qty}",
                style: context.textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
