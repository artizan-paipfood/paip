import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CwIconTolltip extends StatelessWidget {
  final String tooltipMessage;
  final IconData? icon;
  final double? iconSize;
  const CwIconTolltip({
    required this.tooltipMessage,
    super.key,
    this.icon,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        message: tooltipMessage,
        child: Icon(
          icon ?? PIcons.strokeRoundedInformationCircle,
          size: iconSize,
        ));
  }
}
