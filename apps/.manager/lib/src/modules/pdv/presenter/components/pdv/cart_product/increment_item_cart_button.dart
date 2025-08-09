import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class IncrementItemCartButton extends StatelessWidget {
  final int qty;
  final void Function() onIncrement;
  final void Function() onDecrement;

  const IncrementItemCartButton({
    required this.onIncrement,
    required this.onDecrement,
    super.key,
    this.qty = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (qty > 0)
          Badge.count(
            count: qty,
            backgroundColor: context.color.neutral200,
            textColor: context.color.primaryText,
            textStyle: context.textTheme.titleSmall,
          ),
        InkWell(
          onTap: () {},
          borderRadius: 0.5.borderRadiusAll,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (qty > 0 || qty < 0)
                IconButton(
                    onPressed: onDecrement, icon: const Icon(PaipIcons.minus)),
              IconButton(
                  onPressed: onIncrement,
                  icon: const Icon(PaipIcons.add),
                  style: IconButton.styleFrom(
                      backgroundColor:
                          PColors.neutral_.get50.withOpacity(0.05))),
            ],
          ),
        ),
      ],
    );
  }
}
