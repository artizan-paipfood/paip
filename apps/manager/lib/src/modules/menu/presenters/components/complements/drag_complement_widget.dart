import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';

class DragComplementWidget extends StatefulWidget {
  final ComplementModel complement;
  final bool isDragable;
  final void Function()? onTap;

  const DragComplementWidget({
    required this.complement,
    required this.isDragable,
    super.key,
    this.onTap,
  });

  @override
  State<DragComplementWidget> createState() => _DragComplementWidgetState();
}

class _DragComplementWidgetState extends State<DragComplementWidget> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.color.tertiaryColor.withOpacity(0.2),
      borderRadius: 0.5.borderRadiusAll,
      child: InkWell(
        onTap: widget.onTap,
        onHover: (value) => setState(() => isHover = value),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.complement.identifier,
                      style: context.textTheme.bodyMedium
                          ?.copyWith(color: context.color.tertiaryColor))
                  .center,
              0.5.sizedBoxW,
              if (!widget.isDragable && isHover)
                Icon(
                  PaipIcons.close,
                  size: 18,
                  color: context.color.errorColor,
                )
            ],
          ),
        ),
      ),
    );
  }
}
