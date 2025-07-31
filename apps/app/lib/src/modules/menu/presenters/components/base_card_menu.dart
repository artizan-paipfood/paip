import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';

class BaseCardMenu extends StatelessWidget {
  final List<Widget> children;
  final double? width;
  const BaseCardMenu({
    super.key,
    this.children = const [],
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: context.color.primaryBG,
      child: Padding(
        padding: PSize.i.paddingAll + PSize.i.paddingBottom,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
