import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ui/ui.dart';

class PaipLoader extends StatelessWidget {
  final double? size;
  final Color? color;
  const PaipLoader({super.key, this.size = 200, this.color});

  @override
  Widget build(BuildContext context) {
    final targetColor = color ?? context.artColorScheme.mutedForeground;

    return ColorFiltered(
      colorFilter: ColorFilter.mode(targetColor, BlendMode.srcIn),
      child: Lottie.asset(
        'assets/lotties/cards-loader.json',
        width: size,
        height: size,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        package: 'ui',
      ),
    );
  }
}
