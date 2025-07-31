import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';
import 'package:ui/ui.dart';

class PLinearLinearProgessIndicatorWidget extends StatelessWidget {
  final Color? color;
  final bool load;
  const PLinearLinearProgessIndicatorWidget({
    super.key,
    this.color,
    this.load = true,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      minHeight: 7,
      borderRadius: PSize.i.borderRadiusAll,
      color: color ?? context.color.primaryColor,
      backgroundColor: context.color.onPrimaryBG,
      value: !load ? 1 : null,
    );
  }
}
