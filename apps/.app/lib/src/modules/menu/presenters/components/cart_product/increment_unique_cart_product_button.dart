import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class IncrementUniqueCartProductButton extends StatelessWidget {
  final int qty;
  final void Function()? onTap;

  const IncrementUniqueCartProductButton({
    required this.qty,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      radius: 24,
      onTap: onTap,
      child: Icon(
        qty > 0 ? Icons.radio_button_checked_outlined : Icons.radio_button_unchecked_outlined,
        color: qty > 0 ? context.color.primaryColor : context.color.secondaryText,
      ),
    );
  }
}
