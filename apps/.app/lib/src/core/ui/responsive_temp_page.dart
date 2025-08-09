import 'package:flutter/material.dart';
import 'package:app/src/core/helpers/breakpoints.dart';
import 'package:paipfood_package/paipfood_package.dart';

double responsiveTempWidth = 500;

class ResponsiveTempPage extends StatelessWidget {
  final Widget child;

  const ResponsiveTempPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (PaipBreakpoint.phone.isBreakpoint(context)) return child;

    return Scaffold(body: Container(color: context.color.surface, child: Center(child: Container(constraints: BoxConstraints(maxWidth: responsiveTempWidth), child: child))));
  }
}
