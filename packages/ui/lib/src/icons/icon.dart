import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
export './solar.dart';

/// Estilo padrão para ícones PaipIcon
///
/// Exemplo de uso:
/// ```dart
/// DefaultPaipIconStyle(
///   style: PaipIconStyle(
///     color: Colors.blue,
///     size: 32,
///   ),
///   child: Column(
///     children: [
///       PaipIcon('icon_svg_string'), // Herda o estilo padrão
///       PaipIcon('another_icon', color: Colors.red), // Sobrescreve apenas a cor
///     ],
///   ),
/// )
/// ```
class PaipIconStyle {
  final Color? color;
  final double? size;

  const PaipIconStyle({
    this.color,
    this.size = 24,
  });

  PaipIconStyle copyWith({
    Color? color,
    double? size,
  }) {
    return PaipIconStyle(
      color: color ?? this.color,
      size: size ?? this.size,
    );
  }

  PaipIconStyle merge(PaipIconStyle? other) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      size: other.size,
    );
  }
}

/// Widget que fornece um estilo padrão para todos os PaipIcon filhos
///
/// Funciona de forma similar ao DefaultTextStyle do Flutter
class DefaultPaipIconStyle extends InheritedWidget {
  final PaipIconStyle style;
  const DefaultPaipIconStyle({
    super.key,
    required this.style,
    required super.child,
  });

  /// Obtém o estilo padrão do contexto
  static PaipIconStyle? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DefaultPaipIconStyle>()?.style;
  }

  @override
  bool updateShouldNotify(DefaultPaipIconStyle oldWidget) {
    return style != oldWidget.style;
  }
}

class PaipIcon extends StatelessWidget {
  final String icon;
  final Color? color;
  final double? size;

  const PaipIcon(
    this.icon, {
    super.key,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = DefaultPaipIconStyle.of(context);
    final effectiveColor = color ?? defaultStyle?.color ?? context.artColorScheme.foreground;
    final effectiveSize = size ?? defaultStyle?.size ?? 24;

    return SvgPicture.string(
      icon,
      colorFilter: ColorFilter.mode(effectiveColor, BlendMode.srcIn),
      width: effectiveSize,
      height: effectiveSize,
      alignment: Alignment.center,
    );
  }
}
