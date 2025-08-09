import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CwButtonSecondary extends StatelessWidget {
  final IconData? icon;
  final String label;
  final bool enable;
  final void Function()? onPressed;
  final Color color;
  final bool autoToast;
  const CwButtonSecondary({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.enable = true,
    this.color = PColors.primaryColor_,
    this.autoToast = true,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      icon: icon != null
          ? Icon(
              icon,
              color: color,
            )
          : const SizedBox.shrink(),
      label: Text(
        label,
        style: TextStyle(color: color),
      ).center,
      onPressed: enable
          ? () {
              try {
                onPressed?.call();
              } catch (e) {
                if (autoToast) banner.showError(e.toString());
              }
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.25),
        foregroundColor: color.withOpacity(0.25),
        shadowColor: color.withOpacity(0.25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: const Size(50, 50),
        padding: PSize.ii.paddingHorizontal,
        alignment: Alignment.center,
      ),
    );
  }
}
