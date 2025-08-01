import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
export './solar.dart';

class PaipIcon extends StatelessWidget {
  final String icon;
  final Color? color;
  final double? size;

  const PaipIcon(
    this.icon, {
    super.key,
    this.color,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      icon,
      colorFilter: ColorFilter.mode(color ?? context.artColorScheme.foreground, BlendMode.srcIn),
      width: size,
      height: size,
      alignment: Alignment.center,
    );
  }
}
