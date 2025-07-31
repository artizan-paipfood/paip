import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/layout_printer.dart';

import 'package:manager/src/modules/config/presenters/viewmodels/layout_printer_viewmodel.dart';
import 'package:manager/src/modules/menu/presenters/components/complements/switch_required_widget.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:ui/p_drop_menu_form.dart';

class LayoutPropertiesComponent extends StatefulWidget {
  final LayoutPrinterViewmodel viewmodel;
  const LayoutPropertiesComponent({
    required this.viewmodel,
    super.key,
  });

  @override
  State<LayoutPropertiesComponent> createState() => _LayoutPropertiesComponentState();
}

class _LayoutPropertiesComponentState extends State<LayoutPropertiesComponent> {
  TypeSection get typeSection => widget.viewmodel.layoutSelected?.type.type ?? TypeSection.text;
  SectionType get sectionType => widget.viewmodel.layoutSelected?.type ?? SectionType.freeText;
  bool get selected => widget.viewmodel.layoutSelected != null;
  LayoutPrinter? get _layout => widget.viewmodel.layoutSelected;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Properties",
          style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ListenableBuilder(
            listenable: widget.viewmodel,
            builder: (context, child) => Column(
                  children: [
                    if (selected && (typeSection == TypeSection.text || typeSection == TypeSection.cart)) ...[
                      PDropMenuForm<String>(
                        labelText: "Font Size",
                        initialSelection: _layout!.style!.fontSize.toInt().toString(),
                        isExpanded: true,
                        leadingIcon: Icon(PIcons.strokeRoundedTextFont),
                        dropdownMenuEntries: List.generate(
                          90,
                          (index) => (index + 10).toString(),
                        ).map((e) => DropdownMenuEntry(value: e, label: e)).toList(),
                        onSelected: (value) {
                          widget.viewmodel.onEditLayout(_layout!.copyWith(
                              style: _layout!.style!.copyWith(
                            fontSize: double.parse(value!),
                          )));
                        },
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(height: 8),
                      PDropMenuForm<FontWeight>(
                        labelText: "Font Weight",
                        initialSelection: FontWeight.normal,
                        leadingIcon: Icon(PIcons.strokeRoundedTextBold),
                        isExpanded: true,
                        dropdownMenuEntries: FontWeight.values.map((e) => DropdownMenuEntry(value: e, label: e.name.toString())).toList(),
                        onSelected: (value) {
                          widget.viewmodel.onEditLayout(_layout!.copyWith(style: _layout!.style!.copyWith(fontWeight: value)));
                        },
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SwitchRequiredWidget(
                            onChanged: (value) {
                              widget.viewmodel.onEditLayout(_layout!.copyWith(style: _layout!.style!.copyWith(upperCase: value)));
                            },
                            value: _layout!.style!.upperCase,
                            label: 'Uppercase',
                          ),
                          PSize.ii.sizedBoxW,
                          SwitchRequiredWidget(
                            onChanged: (value) {
                              widget.viewmodel.onEditLayout(_layout!.copyWith(style: _layout!.style!.copyWith(isReverse: value)));
                            },
                            value: _layout!.style!.isReverse,
                            label: 'Reverse',
                          ),
                        ],
                      ),
                      PDropMenuForm<TextAlign>(
                        initialSelection: _layout!.style!.textAlign,
                        labelText: 'Align',
                        leadingIcon: Icon(PIcons.strokeRoundedTextAlignCenter),
                        isExpanded: true,
                        dropdownMenuEntries: TextAlign.values.sublist(0, 3).map((e) => DropdownMenuEntry(value: e, label: e.name)).toList(),
                        onSelected: (value) {
                          widget.viewmodel.onEditLayout(_layout!.copyWith(style: _layout!.style!.copyWith(textAlign: value)));
                        },
                      ),
                    ],
                    if (selected && sectionType == SectionType.freeText)
                      CwTextFormFild(
                        label: 'Value',
                        initialValue: _layout!.value,
                        onChanged: (value) {
                          widget.viewmodel.onEditLayout(_layout!.copyWith(value: value));
                          log(_layout!.value);
                        },
                      ),
                    if (selected && sectionType == SectionType.spacer)
                      CwTextFormFild(
                        label: 'Space',
                        initialValue: _layout!.value,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) {
                          widget.viewmodel.onEditLayout(_layout!.copyWith(value: value));
                        },
                      ),
                  ],
                ))
      ],
    );
  }
}
