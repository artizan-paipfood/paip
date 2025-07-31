import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardSelectorComplement extends StatefulWidget {
  final String label;
  final String body;
  final bool isMultiple;
  final void Function() onTap;
  final bool isSelected;

  const CardSelectorComplement({
    required this.label,
    required this.body,
    required this.isMultiple,
    required this.onTap,
    required this.isSelected,
    super.key,
  });

  @override
  State<CardSelectorComplement> createState() => _CardSelectorComplementState();
}

class _CardSelectorComplementState extends State<CardSelectorComplement> {
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    //
    final bool isSelected = widget.isSelected;
    //
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: PSize.i.borderRadiusAll,
      child: InkWell(
        onTap: widget.onTap,
        onHover: (value) => setState(() => onHover = value),
        child: Ink(
          width: 280,
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected || onHover
                  ? context.color.primaryColor
                  : Colors.transparent,
              width: 3,
            ),
            borderRadius: PSize.i.borderRadiusAll,
            color: context.color.onPrimaryBG,
          ),
          child: Padding(
            padding: PSize.i.paddingAll,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label,
                        style: context.textTheme.labelLarge?.copyWith(
                          color:
                              context.isDarkTheme ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        widget.body,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.color.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 65,
                  child: Visibility(
                    visible: widget.isMultiple,
                    replacement: const Icon(PaipIcons.checkCircle),
                    child: Row(
                      children: [
                        const Icon(PaipIcons.minus),
                        PSize.i.sizedBoxW,
                        const Icon(PaipIcons.add)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
