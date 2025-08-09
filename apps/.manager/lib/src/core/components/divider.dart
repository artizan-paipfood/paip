import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CwDivider extends StatelessWidget {
  const CwDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: context.color.secondaryText.withOpacity(0.15),
    );
  }
}
