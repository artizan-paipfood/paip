import 'package:flutter/material.dart';

class ResponsiveExpanded extends StatelessWidget {
  final bool expandend;
  final Widget child;

  const ResponsiveExpanded({
    super.key,
    this.expandend = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (expandend) return Expanded(child: child);
    return child;
  }
}
