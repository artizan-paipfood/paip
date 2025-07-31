import 'package:flutter/material.dart';

import '../../../../paipfood_package.dart';

class CwOutlineButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final void Function()? onPressed;
  final Color? color;
  final bool enable;
  final bool autoToast;
  final void Function()? onLongPress;
  const CwOutlineButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.color,
    this.enable = true,
    this.autoToast = true,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: enable
          ? () {
              try {
                onPressed?.call();
              } catch (e) {
                if (autoToast) banner.showError(e.toString());
              }
            }
          : null,
      onLongPress: onLongPress,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(50, 50),
        padding: PSize.ii.paddingHorizontal,
        alignment: Alignment.center,
        foregroundColor: color ?? PColors.neutral_.shade500,
        side: BorderSide(
          color: PColors.neutral_.shade300,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    icon,
                    color: color ?? context.color.primaryText,
                    size: 18,
                  ),
                )
              : const SizedBox.shrink(),
          Text(
            label,
            style: TextStyle(color: color ?? context.color.neutral950),
          ).center,
        ],
      ),
    );
  }
}
