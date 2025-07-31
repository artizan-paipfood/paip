import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardSelectCategoryType extends StatefulWidget {
  final String label;
  final String body;
  final String pathImage;
  final CategoryType categoryType;
  final void Function(CategoryType categoryType) onTap;
  final bool isSelected;
  const CardSelectCategoryType({
    required this.label,
    required this.body,
    required this.pathImage,
    required this.categoryType,
    required this.onTap,
    required this.isSelected,
    super.key,
  });

  @override
  State<CardSelectCategoryType> createState() => _CardSelectCategoryTypeState();
}

class _CardSelectCategoryTypeState extends State<CardSelectCategoryType> {
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    //

    //
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: PSize.i.borderRadiusAll,
      elevation: widget.isSelected ? 2 : 0,
      child: InkWell(
        onTap: () => widget.onTap(widget.categoryType),
        onHover: (value) => setState(() => onHover = value),
        child: Ink(
          width: 200,
          height: 260,
          decoration: BoxDecoration(
            color: widget.isSelected || onHover ? context.color.primaryColor : context.color.onPrimaryBG,
          ),
          child: Padding(
            padding: PSize.i.paddingAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset(widget.pathImage, height: 150, width: 150)),
                PSize.i.sizedBoxH,
                Text(
                  widget.label,
                  style: context.textTheme.labelLarge?.copyWith(
                    color: widget.isSelected || onHover ? Colors.white : context.color.primaryText,
                  ),
                ),
                Text(
                  widget.body,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: widget.isSelected || onHover ? Colors.white : context.color.primaryText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
