import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';

class TagButtonQtyFlavorPizza extends StatefulWidget {
  final bool isSelected;
  final void Function()? onTap;
  final String label;
  final Color? colorSelected;
  const TagButtonQtyFlavorPizza({
    super.key,
    this.isSelected = false,
    this.onTap,
    this.label = '',
    this.colorSelected,
  });

  @override
  State<TagButtonQtyFlavorPizza> createState() => _TagButtonQtyFlavorPizzaState();
}

class _TagButtonQtyFlavorPizzaState extends State<TagButtonQtyFlavorPizza> {
  bool _isHover = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: 0.5.borderRadiusAll,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: 0.5.borderRadiusAll,
        onHover: (value) => setState(() => _isHover = value),
        child: Ink(
            decoration: BoxDecoration(
                color:
                    widget.isSelected || _isHover ? widget.colorSelected ?? context.color.tertiaryColor : context.color.primaryText.withOpacity(0.07),
                borderRadius: 0.5.borderRadiusAll,
                border: Border.all(
                    color: widget.isSelected
                        ? widget.colorSelected?.withOpacity(0.2) ?? context.color.tertiaryColor.withOpacity(0.2)
                        : context.color.primaryText.withOpacity(0.07))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              child: Text(widget.label.toUpperCase(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: widget.isSelected || _isHover ? context.color.neutral.get950 : context.color.secondaryText,
                    fontWeight: FontWeight.bold,
                  )).center,
            )),
      ),
    );
  }
}
