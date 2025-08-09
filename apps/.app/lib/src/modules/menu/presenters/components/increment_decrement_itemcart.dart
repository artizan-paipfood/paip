import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class IncrementDecrementItemCar extends StatelessWidget {
  final int qty;
  final void Function() onIncrement;
  final void Function() onDecrement;

  const IncrementDecrementItemCar({
    required this.onIncrement,
    required this.onDecrement,
    super.key,
    this.qty = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: 0.5.borderRadiusAll,
        color: context.color.onPrimaryBG,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (qty > 0 || qty < 0)
            IconButton(
                onPressed: onDecrement,
                icon: Icon(qty <= 1
                    ? PaipIcons.trash
                    : PIcons.strokeRoundedMinusSign)),
          if (qty > 0)
            SizedBox(width: 20, child: Center(child: Text(qty.toString()))),
          IconButton(
              onPressed: onIncrement,
              icon: Icon(
                PIcons.strokeRoundedPlusSign,
                color: context.color.primaryColor,
              )),
        ],
      ),
    );
  }
}
