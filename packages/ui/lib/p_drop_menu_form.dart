import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PDropMenuForm<T> extends FormField<T> {
  final String? labelText;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final List<DropdownMenuEntry<T>> Function(List<DropdownMenuEntry<T>> entries, String filter)? filterCallback;
  final TextEditingController? controller;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final double? menuHeight;
  final bool isExpanded;
  final String? hintText;

  PDropMenuForm({
    required this.dropdownMenuEntries,
    super.key,
    this.labelText,
    this.filterCallback,
    this.controller,
    super.validator,
    void Function(T?)? onSelected,
    T? initialSelection,
    String? errorText,
    this.leadingIcon,
    this.trailingIcon,
    this.menuHeight,
    this.isExpanded = false,
    this.hintText,
  }) : super(
          initialValue: initialSelection, // Validação quando FormState é acionado
          builder: (FormFieldState<T> fieldState) {
            return _PDropMenuWidget<T>(
              labelText: labelText,
              leadingIcon: leadingIcon,
              trailingIcon: trailingIcon,
              dropdownMenuEntries: dropdownMenuEntries,
              filterCallback: filterCallback,
              controller: controller,
              errorText: fieldState.errorText,
              isExpanded: isExpanded,
              hintText: hintText,
              onSelected: (T? newValue) {
                fieldState.didChange(newValue);
                if (onSelected != null) {
                  onSelected(newValue);
                }
              },
              selectedItem: fieldState.value,
              menuHeight: menuHeight,
            );
          },
        );
}

class _PDropMenuWidget<T> extends StatefulWidget {
  final String? labelText;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final List<DropdownMenuEntry<T>> Function(List<DropdownMenuEntry<T>> entries, String filter)? filterCallback;
  final TextEditingController? controller;
  final String? errorText;
  final T? selectedItem;
  final void Function(T?) onSelected;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final double? menuHeight;
  final bool isExpanded;
  final String? hintText;

  const _PDropMenuWidget({
    super.key,
    this.labelText,
    required this.dropdownMenuEntries,
    this.filterCallback,
    this.controller,
    this.errorText,
    required this.onSelected,
    this.selectedItem,
    this.leadingIcon,
    this.trailingIcon,
    this.menuHeight,
    this.isExpanded = false,
    this.hintText,
  });

  @override
  State<_PDropMenuWidget<T>> createState() => _PDropMenuWidgetState<T>();
}

class _PDropMenuWidgetState<T> extends State<_PDropMenuWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null) Padding(padding: const EdgeInsets.only(bottom: 4), child: Text(widget.labelText!, style: context.textTheme.labelMedium, overflow: TextOverflow.ellipsis)),
          DropdownMenu<T>(
            leadingIcon: widget.leadingIcon,
            trailingIcon: widget.trailingIcon,
            expandedInsets: widget.isExpanded ? const EdgeInsets.all(0) : null,
            dropdownMenuEntries: widget.dropdownMenuEntries,
            hintText: widget.hintText,
            initialSelection: widget.selectedItem,
            enableFilter: widget.filterCallback != null,
            onSelected: widget.onSelected,
            errorText: widget.errorText,
            alignmentOffset: Offset(180, 0), // Exibe o erro do FormField se houver
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: context.isDarkTheme ? 0 : 1, color: context.isDarkTheme ? context.color.onPrimaryBG : PColors.neutral_.get300)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: context.color.primaryColor)),
              errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: context.color.errorColor)),
              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(width: 2.5, color: context.color.errorColor)),
              isDense: true,
              constraints: const BoxConstraints(
                maxHeight: 40,
                minHeight: 40,
              ),
              fillColor: context.color.onPrimaryBG,
              filled: true,
              errorMaxLines: 10,
              disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0, color: context.color.onPrimaryBG)),
              floatingLabelStyle: TextStyle(color: context.color.primaryColor),
              prefixIconColor: context.color.primaryColor,
            ),
            filterCallback: widget.filterCallback,
            menuHeight: widget.menuHeight,
            controller: widget.controller,
          ),
        ],
      ),
    );
  }
}
