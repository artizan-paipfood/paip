import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class IncrementUniqueCartProductButton extends StatelessWidget {
  final int qty;

  const IncrementUniqueCartProductButton({
    required this.qty, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      qty > 0 ? Icons.radio_button_checked_outlined : Icons.radio_button_unchecked_outlined,
      color: qty > 0 ? context.color.primaryColor : context.color.secondaryText,
    );
  }
}
