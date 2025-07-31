// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CwContainerShadow extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final BorderRadius? borderRadius;
  const CwContainerShadow({super.key, this.width, this.height, this.child, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: context.color.primaryBG,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: child,
      ),
    );
  }
}
