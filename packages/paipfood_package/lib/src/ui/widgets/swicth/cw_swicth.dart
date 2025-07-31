import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PSwicth extends StatelessWidget {
  final bool value;
  final void Function(bool value)? onChanged;
  const PSwicth({
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      thumbColor: WidgetStatePropertyAll(value ? Colors.white : context.color.neutral.get300),
      trackOutlineColor: WidgetStatePropertyAll(value ? PColors.primaryColor_ : context.color.neutral.get500),
      onChanged: onChanged,
    );
  }
}
