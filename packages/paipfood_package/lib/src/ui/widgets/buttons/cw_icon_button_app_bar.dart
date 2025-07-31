import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';

class CwIconButtonAppBar extends StatelessWidget {
  final void Function()? onPressed;
  final IconData? icon;
  const CwIconButtonAppBar({
    super.key,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: onPressed ??
            () {
              Navigator.of(context).maybePop();
            },
        icon: Icon(icon ?? Icons.arrow_back),
        style: IconButton.styleFrom(
            backgroundColor: context.color.neutral100.withOpacity(0.5), padding: EdgeInsets.zero, visualDensity: VisualDensity.comfortable),
      ),
    );
  }
}
