import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PButton extends StatefulWidget {
  final IconData? icon;
  final String label;
  final bool enable;
  final void Function()? onPressed;
  final Future Function()? onPressedFuture;
  final Color? color;
  final Color? colorText;
  final bool autoToast;
  final String? errorGeneric;
  final bool autofocus;
  final MainAxisAlignment mainAxisAlignment;
  final TextStyle? textStyle;
  final void Function()? onLongPress;
  const PButton({
    required this.label,
    this.onPressed,
    this.onPressedFuture,
    this.enable = true,
    this.onLongPress,
    super.key,
    this.icon,
    this.color,
    this.autoToast = true,
    this.errorGeneric,
    this.colorText,
    this.autofocus = false,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.textStyle,
  });

  @override
  State<PButton> createState() => _PButtonState();
}

class _PButtonState extends State<PButton> {
  bool _enable = true;
  var load = ValueNotifier(false);
  Color get _color => widget.color ?? context.color.primaryColor;

  @override
  void initState() {
    _enable = widget.enable;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      autofocus: widget.autofocus,
      onLongPress: widget.onLongPress,
      onPressed: () async {
        if (_enable == false) return;
        if (widget.onPressedFuture != null && widget.enable) {
          _enable = false;
          setState(() {
            load.value = true;
          });

          try {
            await widget.onPressedFuture?.call();
          } catch (e) {
            if (widget.autoToast) banner.showError(widget.errorGeneric ?? e.toString());
          }
          if (mounted) {
            setState(() {
              load.value = false;
            });
          }

          _enable = true;
        } else if (widget.enable) {
          try {
            widget.onPressed?.call();
          } catch (e) {
            if (widget.autoToast) banner.showError(e.toString());
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _color,
        minimumSize: const Size(50, 50),
        padding: PSize.ii.paddingHorizontal,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: ValueListenableBuilder(
          valueListenable: load,
          builder: (context, isLoad, _) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: widget.mainAxisAlignment,
              children: [
                if (widget.icon != null)
                  Padding(
                    padding: PSize.i.paddingRight,
                    child: Icon(
                      widget.icon,
                      color: widget.colorText ?? Colors.white,
                      size: 18,
                    ),
                  ),
                Text(
                  widget.label,
                  style: widget.textStyle ?? TextStyle(color: widget.colorText ?? PColors.light.primaryBG),
                ),
                if (isLoad)
                  Padding(
                    padding: PSize.i.paddingLeft,
                    child: SizedBox(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(
                          color: widget.colorText ?? Colors.white,
                          strokeWidth: 3,
                          strokeCap: StrokeCap.round,
                        )),
                  ),
              ],
            );
          }),
    );
  }
}
