import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SwitchRequiredWidget extends StatefulWidget {
  final void Function(bool)? onChanged;
  final bool value;
  final String? label;
  const SwitchRequiredWidget({required this.onChanged, required this.value, this.label, super.key});

  @override
  State<SwitchRequiredWidget> createState() => _SwitchRequiredWidgetState();
}

class _SwitchRequiredWidgetState extends State<SwitchRequiredWidget> {
  late bool _isRequired = widget.value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: context.color.surface, borderRadius: PSize.i.borderRadiusAll),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.label ?? "${context.i18n.obrigatorio}?", style: context.textTheme.labelLarge),
            PSize.i.sizedBoxW,
            Switch(
              value: widget.value,
              thumbColor: WidgetStatePropertyAll(!context.isDarkTheme && !_isRequired && !widget.value ? context.color.secondaryText : Colors.white),
              onChanged: (value) {
                setState(() {
                  widget.onChanged?.call(value);
                  _isRequired = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
