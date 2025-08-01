import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class PaipLoader extends StatelessWidget {
  final double? size;
  final Color? color;
  const PaipLoader({super.key, this.size = 24, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/bars-loader.svg',
      colorFilter: ColorFilter.mode(color ?? context.artColorScheme.primary, BlendMode.srcIn),
      width: size,
      height: size,
      alignment: Alignment.center,
      package: 'ui',
    );
  }
}
