import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';

class TagWidgetButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color? color;
  final Color? colorText;
  final Color? colorSelected;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;
  const TagWidgetButton({super.key, this.label = '', this.isSelected = false, this.color, this.colorText, this.colorSelected, this.padding, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: 0.5.borderRadiusAll,
      color: isSelected ? (colorSelected ?? PColors.primaryColor_) : context.color.neutral200,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: onTap,
        borderRadius: 0.5.borderRadiusAll,
        child: Ink(
          decoration: BoxDecoration(borderRadius: 0.5.borderRadiusAll),
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            child: Text(
              label,
              style: context.textTheme.bodyMedium?.copyWith(
                color: isSelected ? PColors.neutral_.get50 : context.color.secondaryText,
              ),
            ).center,
          ),
        ),
      ),
    );
  }
}
