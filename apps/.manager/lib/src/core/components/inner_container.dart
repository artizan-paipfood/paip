// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';

class CwInnerContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? width;
  const CwInnerContainer({
    required this.child,
    super.key,
    this.padding,
    this.color,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(color: color ?? context.color.surface, borderRadius: 0.3.borderRadiusAll),
      child: Padding(padding: padding ?? PSize.i.paddingAll, child: child),
    );
  }
}
