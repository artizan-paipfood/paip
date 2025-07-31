// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';

class CwColorSelector extends StatefulWidget {
  final ThemeEnum theme;
  final void Function() onTap;
  final bool isSelected;
  const CwColorSelector({
    required this.theme,
    required this.onTap,
    super.key,
    this.isSelected = false,
  });

  @override
  State<CwColorSelector> createState() => _CwColorSelectorState();
}

class _CwColorSelectorState extends State<CwColorSelector> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (value) {
        setState(() {
          _isHovered = value;
        });
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          border: Border.all(color: widget.theme.color, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: widget.isSelected || _isHovered
            ? Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.theme.color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
