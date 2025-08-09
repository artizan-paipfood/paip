import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ContainerPulse extends StatelessWidget {
  final Color? color;
  final Widget child;
  final double? radius;

  final double maxScale;

  const ContainerPulse({
    required this.child,
    this.maxScale = 3,
    super.key,
    this.color,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular((radius ?? 1) / 10),
            color: color,
          ),
        )
            .animate(
              onPlay: (controller) => controller.repeat(),
            )
            .scaleXY(begin: 0.5, end: maxScale, curve: Curves.easeInOut, duration: 1000.ms)
            .then()
            .scaleXY(begin: maxScale, end: 0.5, curve: Curves.easeInOut),
        Material(borderRadius: BorderRadius.all(Radius.circular(radius ?? 1)), child: child),
      ],
    );
  }
}
