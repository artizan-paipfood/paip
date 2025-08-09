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
    return SizedBox(
      child: InkWell(
        onTap: () {},
        borderRadius: 0.5.borderRadiusAll,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (qty > 0 || qty < 0) IconButton(onPressed: onDecrement, icon: const Icon(PIcons.strokeRoundedMinusSign)),
            if (qty > 0) SizedBox(width: 20, child: Center(child: Text(qty.toString()))),
            IconButton(
                onPressed: onIncrement,
                icon: const Icon(PIcons.strokeRoundedPlusSign),
                style: IconButton.styleFrom(backgroundColor: PColors.neutral_.get50.withOpacity(0.05))),
          ],
        ),
      ),
    );
  }
}
