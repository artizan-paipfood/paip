import 'package:flutter/material.dart';

import 'package:manager/src/modules/pdv/aplication/stores/menu_pdv_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ToggleButtonCategory extends StatefulWidget {
  final void Function()? onTap;
  final CategoryModel category;

  const ToggleButtonCategory({
    required this.category,
    this.onTap,
    super.key,
  });

  @override
  State<ToggleButtonCategory> createState() => _ToggleButtonCategoryState();
}

class _ToggleButtonCategoryState extends State<ToggleButtonCategory> {
  late final store = context.read<MenuPdvStore>();
  bool _isSelected() => widget.category == store.categorySelected || isHover;
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Material(
        color: _isSelected() ? context.color.primaryText : Colors.transparent,
        borderRadius: 0.5.borderRadiusAll,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          hoverColor: context.color.neutral1000,
          onTap: widget.onTap ?? () {},
          onHover: (value) => setState(() => isHover = value),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: 0.5.borderRadiusAll,
              border: Border.all(
                color: context.color.primaryText,
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.category.name, style: context.textTheme.bodyMedium?.copyWith(color: _isSelected() ? context.color.neutral50 : context.color.primaryText)).center,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
