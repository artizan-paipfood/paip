import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CwModal extends StatelessWidget {
  final Widget? child;
  final double? height;

  const CwModal({
    super.key,
    this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
          color: context.color.primaryBG,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PSize.ii.sizedBoxH,
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(color: Colors.grey.shade600, borderRadius: PSize.i.borderRadiusAll),
          ),
          PSize.ii.sizedBoxH,
          child ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
