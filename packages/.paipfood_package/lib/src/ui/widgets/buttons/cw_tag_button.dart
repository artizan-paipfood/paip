import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';

class CwTagButton extends StatefulWidget {
  final bool isSelected;
  final void Function()? onTap;
  final String label;
  final Color? colorSelected;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  const CwTagButton({
    super.key,
    this.isSelected = true,
    this.onTap,
    this.label = '',
    this.colorSelected,
    this.padding,
    this.style,
  });

  @override
  State<CwTagButton> createState() => _CwTagButtonState();
}

class _CwTagButtonState extends State<CwTagButton> {
  bool _isHover = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: 0.5.borderRadiusAll,
      child: InkWell(
        onTap: widget.onTap,
        onHover: (value) => setState(() => _isHover = value),
        child: Ink(
            decoration: BoxDecoration(
                color: widget.isSelected || _isHover
                    ? widget.colorSelected?.withOpacity(0.2) ?? context.color.tertiaryColor.withOpacity(0.2)
                    : context.color.primaryText.withOpacity(0.07),
                borderRadius: 0.5.borderRadiusAll,
                border: Border.all(
                    color: widget.isSelected
                        ? widget.colorSelected?.withOpacity(0.2) ?? context.color.tertiaryColor.withOpacity(0.2)
                        : context.color.primaryText.withOpacity(0.07))),
            child: Padding(
              padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 4),
              child: Text(widget.label,
                      style: widget.style?.copyWith(
                            color: widget.isSelected || _isHover ? widget.colorSelected ?? context.color.tertiaryColor : context.color.secondaryText,
                            fontWeight: FontWeight.bold,
                          ) ??
                          context.textTheme.bodySmall?.copyWith(
                            color: widget.isSelected || _isHover ? widget.colorSelected ?? context.color.tertiaryColor : context.color.secondaryText,
                            fontWeight: FontWeight.bold,
                          ))
                  .center,
            )),
      ),
    );
  }
}
