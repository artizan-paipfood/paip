import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';

import 'package:paipfood_package/paipfood_package.dart';

class EditOrderCommandComponent extends StatefulWidget {
  final Function() onNewSheet;
  final Function() onDelete;
  final int length;

  const EditOrderCommandComponent({required this.onNewSheet, required this.onDelete, required this.length, super.key});

  @override
  State<EditOrderCommandComponent> createState() => _EditOrderCommandComponentState();
}

class _EditOrderCommandComponentState extends State<EditOrderCommandComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${widget.length} ${context.i18n.comandas}'.toUpperCase()),
        PSize.ii.sizedBoxH,
        Row(
          children: [
            Expanded(
              child: CwOutlineButton(
                label: context.i18n.adicionarComanda.toUpperCase(),
                onPressed: () {
                  widget.onNewSheet();
                },
              ),
            ),
          ],
        ),
        PSize.ii.sizedBoxH,
        Row(children: [Expanded(child: PButton(label: context.i18n.removerComanda.toUpperCase(), color: context.color.errorColor, onPressed: () => widget.onDelete()))]),
        PSize.ii.sizedBoxH,
        const Spacer(),
        Row(children: [Expanded(child: PButton(label: context.i18n.salvar.toUpperCase(), onPressed: () => widget.onDelete()))]),
      ],
    ).animate().shimmer();
  }
}
