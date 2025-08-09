import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';

class PToggleNivelWidget extends StatefulWidget {
  final bool isSelected;
  final void Function()? onTap;
  final String label;
  final PToggleNivelStyle? style;
  const PToggleNivelWidget({
    required this.isSelected,
    required this.label,
    super.key,
    this.onTap,
    this.style,
  });

  @override
  State<PToggleNivelWidget> createState() => _PToggleNivelWidgetState();
}

class _PToggleNivelWidgetState extends State<PToggleNivelWidget> {
  PToggleNivelStyle get _style => widget.style ?? PToggleNivelStyle(backgroundColor: PColors.light.neutral700, selectedBackgroundColor: Colors.white, textColor: Colors.white, selectedTextColor: Colors.black, selectedHoverColor: PColors.light.neutral900);
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: 0.5.borderRadiusTopLeft + 0.5.borderRadiusTopRight,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: widget.isSelected ? _style.selectedBackgroundColor : _style.backgroundColor,
      child: InkWell(
        hoverColor: widget.isSelected ? _style.selectedBackgroundColor : _style.selectedHoverColor,
        onTap: widget.onTap,
        child: SizedBox(
          height: 45,
          child: Center(
            child: Padding(
              padding: PSize.ii.paddingHorizontal,
              child: Text(widget.label, style: context.textTheme.bodyMedium?.copyWith(color: widget.isSelected ? _style.selectedTextColor : _style.textColor)),
            ),
          ),
        ),
      ),
    );
  }

  PToggleNivelStyle styleFrom({Color? textColor, Color? selectedTextColor, Color? backgroundColor, Color? selectedBackgroundColor, Color? selectedHoverColor}) {
    return PToggleNivelStyle(backgroundColor: textColor ?? _style.backgroundColor, selectedBackgroundColor: selectedBackgroundColor ?? _style.selectedBackgroundColor, selectedHoverColor: selectedHoverColor ?? _style.selectedHoverColor, textColor: textColor ?? _style.textColor, selectedTextColor: selectedTextColor ?? _style.selectedTextColor);
  }
}

class PToggleNivelStyle {
  final Color textColor;
  final Color selectedTextColor;
  final Color backgroundColor;
  final Color selectedBackgroundColor;

  final Color selectedHoverColor;
  PToggleNivelStyle({
    required this.textColor,
    required this.selectedTextColor,
    required this.backgroundColor,
    required this.selectedBackgroundColor,
    required this.selectedHoverColor,
  });
}
