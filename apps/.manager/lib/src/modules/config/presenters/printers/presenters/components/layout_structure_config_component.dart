import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/divider.dart';
import 'package:manager/src/modules/config/presenters/printers/presenters/components/layout_card_reordenable.dart';
import 'package:manager/src/modules/config/presenters/printers/presenters/components/layout_dialog_add.dart';
import 'package:manager/src/modules/config/presenters/viewmodels/layout_printer_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:ui/p_drop_menu_form.dart';

class LayoutStructureConfigComponent extends StatelessWidget {
  final OrderModel order;
  final LayoutPrinterViewmodel viewmodel;
  final void Function() onSave;
  const LayoutStructureConfigComponent({required this.order, required this.viewmodel, required this.onSave, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: CwTextFormFild(label: "Layout name", initialValue: viewmodel.layoutPrinter.layoutPrinter.name, onChanged: (value) => viewmodel.onEditDto(viewmodel.layoutPrinter.copyWith(layoutPrinter: viewmodel.layoutPrinter.layoutPrinter.copyWith(name: value))))),
            PSize.spacer.sizedBoxW,
            PDropMenuForm<String>(labelText: "Font Family", initialSelection: "Roboto", leadingIcon: Icon(PIcons.strokeRoundedTextFont), dropdownMenuEntries: ["Roboto", "Arial", "Montserrat"].map((e) => DropdownMenuEntry(value: e, label: e)).toList(), onSelected: (value) {}),
          ],
        ),
        PSize.i.sizedBoxH,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CwOutlineButton(
              label: 'Adicionar layout',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => LayoutDialogAdd(
                    onSelected: (layout) {
                      viewmodel.addLayout(layout);
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
              icon: Icons.add,
            ),
            PSize.ii.sizedBoxW,
            PButton(label: context.i18n.salvar, onPressed: onSave),
          ],
        ),
        CwDivider(),
        Expanded(
          child: ListenableBuilder(
            listenable: viewmodel,
            builder: (context, _) {
              return ReorderableListView.builder(
                shrinkWrap: true,
                buildDefaultDragHandles: false,
                itemCount: viewmodel.layouts.length,
                scrollController: viewmodel.scrollController,
                itemBuilder: (context, index) => LayoutCardReordenable(
                  key: ValueKey(index),
                  order: order,
                  printerLayout: viewmodel.layouts[index],
                  onSelect: () {
                    viewmodel.selectLayout(viewmodel.layouts[index]);
                  },
                  isSelected: viewmodel.isSelected(viewmodel.layouts[index].index),
                  onRemove: () {
                    viewmodel.removeLayout(viewmodel.layouts[index]);
                  },
                ),
                onReorder: (oldIndex, newIndex) {
                  viewmodel.ordening(oldIndex: oldIndex, newIndex: newIndex);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
