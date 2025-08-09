import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CwTextFormFild extends StatefulWidget {
  final String? label;
  final String? initialValue;
  final void Function(String value)? onChanged;
  final void Function(String value)? onFieldSubmitted;
  final MaskInputController? maskUtils;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final String? hintText;
  final bool? autofocus;
  final bool? autocorrect;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final bool expanded;
  final int? flex;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final String? helperText;
  final String? prefixText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool filled;
  final bool enabled;
  final String? tooltipMessage;
  final IconData? tooltipIcon;
  final String? counterText;
  final AutovalidateMode? autovalidateMode;
  final Color? fillColor;
  final BoxConstraints? constraints;
  final Color? textColor;
  final TextStyle? style;
  final bool underline;
  final TextCapitalization textCapitalization;
  final String? suffixText;
  final void Function()? onTap;
  final TextStyle? hintStyle;
  const CwTextFormFild({
    super.key,
    this.label,
    this.initialValue,
    this.onChanged,
    this.onFieldSubmitted,
    this.controller,
    this.validator,
    this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.expanded = false,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.helperText,
    this.prefixText,
    this.inputFormatters,
    this.keyboardType,
    this.filled = true,
    this.enabled = true,
    this.tooltipMessage,
    this.tooltipIcon,
    this.counterText,
    this.flex,
    this.maskUtils,
    this.autovalidateMode,
    this.autofocus = false,
    this.autocorrect = false,
    this.fillColor,
    this.constraints,
    this.textColor,
    this.style,
    this.hintStyle,
    this.underline = false,
    this.textCapitalization = TextCapitalization.sentences,
    this.suffixText,
    this.onTap,
  });

  const CwTextFormFild.underlinded({
    super.key,
    this.label,
    this.initialValue,
    this.onChanged,
    this.onFieldSubmitted,
    this.controller,
    this.validator,
    this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.expanded = false,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.helperText,
    this.prefixText,
    this.inputFormatters,
    this.keyboardType,
    this.filled = true,
    this.enabled = true,
    this.tooltipMessage,
    this.tooltipIcon,
    this.counterText,
    this.flex,
    this.maskUtils,
    this.autovalidateMode,
    this.autofocus = false,
    this.autocorrect = false,
    this.fillColor,
    this.constraints,
    this.textColor,
    this.style,
    this.hintStyle,
    this.underline = true,
    this.textCapitalization = TextCapitalization.sentences,
    this.suffixText,
    this.onTap,
  });

  @override
  State<CwTextFormFild> createState() => _CwTextFormFildState();

  InputDecoration decoration(BuildContext context, {required bool obscure, Function(bool value)? toggleObscure}) {
    return InputDecoration(
        filled: filled,
        constraints: constraints,
        isDense: true,
        fillColor: fillColor ?? context.color.onPrimaryBG,
        enabled: enabled,
        errorMaxLines: 10,
        helperText: helperText,
        counterText: counterText,
        prefixIconColor: context.color.primaryColor,
        prefixText: prefixText,
        hintStyle: hintStyle,
        prefixIcon: prefixIcon,
        prefixStyle: textColor != null ? TextStyle(color: textColor!.withOpacity(0.8)) : null,
        suffixText: suffixText,
        labelStyle: context.textTheme.labelLarge?.muted(context),
        suffixIcon: obscureText
            ? ExcludeFocus(
                child: IconButton(
                  onPressed: () => toggleObscure?.call(!obscure),
                  icon: Icon(obscure ? PIcons.strokeRoundedViewOff : PIcons.strokeRoundedView),
                ),
              )
            : suffixIcon,
        hintText: hintText ?? maskUtils?.hint);
  }
}

class _CwTextFormFildState extends State<CwTextFormFild> {
  FocusNode? focusNode;
  late bool _obscure;

  @override
  void initState() {
    _obscure = widget.obscureText;
    focusNode = widget.maskUtils?.getFocusNode?.call();
    super.initState();
  }

  @override
  void dispose() {
    focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget child = Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null && !widget.underline)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Expanded(child: Text(widget.label!, style: context.textTheme.labelMedium, overflow: TextOverflow.ellipsis)),
                  widget.tooltipMessage != null ? CwIconTolltip(tooltipMessage: widget.tooltipMessage!, icon: widget.tooltipIcon, iconSize: 18) : const SizedBox.shrink(),
                ],
              ),
            ),
          TextFormField(
            textCapitalization: widget.textCapitalization,
            focusNode: widget.focusNode ?? focusNode,
            obscureText: _obscure,
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters ?? widget.maskUtils?.inpuFormatters,
            controller: widget.controller,
            onTap: widget.onTap,
            onChanged: () {
              if (widget.maskUtils != null && widget.maskUtils?.onChanged != null) {
                return (value) {
                  widget.maskUtils!.onChanged!.call(value);
                  widget.onChanged?.call(value);
                };
              }
              return widget.onChanged;
            }(),
            style: widget.style ?? context.textTheme.titleMedium!.copyWith(color: widget.textColor),
            autofocus: widget.autofocus!,
            onFieldSubmitted: widget.onFieldSubmitted,
            autocorrect: widget.autocorrect!,
            cursorColor: context.color.primaryColor,
            minLines: widget.obscureText ? 1 : widget.minLines,
            maxLines: widget.obscureText ? 1 : widget.maxLines,
            validator: widget.validator ?? widget.maskUtils?.validator,
            keyboardType: widget.keyboardType ?? widget.maskUtils?.keyboardType,
            initialValue: (widget.maskUtils != null && widget.initialValue != null) ? Utils.maskUltisToString(widget.initialValue!, widget.maskUtils!) : widget.initialValue,
            autovalidateMode: () {
              if (widget.autovalidateMode != null) return widget.autovalidateMode;
              if (widget.maskUtils != null && widget.maskUtils!.autovalidateMode != null) return widget.maskUtils!.autovalidateMode;
              return null;
            }(),
            decoration: widget.underline
                ? widget.decoration(context, obscure: _obscure, toggleObscure: (obscure) => setState(() => _obscure = obscure)).copyWith(
                      alignLabelWithHint: true,
                      isDense: true,
                      label: Text(widget.label ?? ''),
                      filled: false,
                    )
                : widget.decoration(context, obscure: _obscure, toggleObscure: (obscure) => setState(() => _obscure = obscure)).copyWith(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: context.isDarkTheme ? 0 : 1, color: context.isDarkTheme ? context.color.neutral400 : PColors.neutral_.get300)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: context.color.primaryColor)),
                      errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: context.color.errorColor)),
                      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(width: 2.5, color: context.color.errorColor)),
                      disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0, color: context.color.onPrimaryBG)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      floatingLabelStyle: TextStyle(color: context.color.primaryColor),
                    ),
          )
        ],
      ),
    );
    return widget.expanded ? Expanded(flex: widget.flex ?? 1, child: child) : child;
  }
}
