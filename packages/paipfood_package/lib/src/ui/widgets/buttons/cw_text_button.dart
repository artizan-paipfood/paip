import 'package:flutter/material.dart';

import '../../../../paipfood_package.dart';

class CwTextButton extends StatefulWidget {
  final IconData? icon;
  final String label;
  final Color? colorText;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;
  final void Function()? onPressed;
  final bool enable;
  final bool autoToast;
  final Future Function()? onPressedFuture;
  final String? errorGeneric;
  const CwTextButton({
    required this.label,
    super.key,
    this.icon,
    this.colorText,
    this.iconColor,
    this.padding,
    this.enable = true,
    this.autoToast = true,
    this.onPressed,
    this.onPressedFuture,
    this.errorGeneric,
  });

  @override
  State<CwTextButton> createState() => _CwTextButtonState();
}

class _CwTextButtonState extends State<CwTextButton> {
  bool _enable = true;
  var load = ValueNotifier(false);

  @override
  void initState() {
    _enable = widget.enable;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if (_enable == false) return;
        if (widget.onPressedFuture != null && widget.enable) {
          _enable = false;
          load.value = true;

          try {
            await widget.onPressedFuture?.call();
          } catch (e) {
            if (widget.autoToast) banner.showError(widget.errorGeneric ?? e.toString());
          }

          load.value = false;
          _enable = true;
        } else if (widget.enable) {
          try {
            widget.onPressed?.call();
          } catch (e) {
            if (widget.autoToast) banner.showError(e.toString());
          }
        }
      },
      style: TextButton.styleFrom(
        minimumSize: const Size(50, 50),
        padding: PSize.ii.paddingHorizontal,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        foregroundColor: widget.colorText,
      ),
      child: ValueListenableBuilder(
          valueListenable: load,
          builder: (context, isLoad, _) {
            if (isLoad) {
              return SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(
                    color: widget.colorText ?? context.color.primaryText,
                    strokeWidth: 3,
                  ));
            }
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.icon != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          widget.icon,
                          size: 18,
                          color: widget.colorText ?? context.color.primaryText,
                        ),
                      )
                    : const SizedBox.shrink(),
                Text(
                  widget.label,
                  style: TextStyle(color: widget.colorText ?? context.color.primaryText),
                ),
              ],
            );
          }),
    );
  }
}
