import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';

import 'package:manager/src/modules/table/presenter/components/table_widget.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DialogOpenTable extends StatefulWidget {
  final TableModel table;
  final void Function(bool value) onPop;
  const DialogOpenTable({required this.table, required this.onPop, super.key});

  @override
  State<DialogOpenTable> createState() => _DialogOpenTableState();
}

class _DialogOpenTableState extends State<DialogOpenTable> {
  bool _canPop = false;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop,
      onPopInvokedWithResult: (didPop, result) => widget.onPop(result is bool ? result : false),
      child: AlertDialog(
        title: Text(context.i18n.desejaAbrirMesaParaVenda),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableWidget(table: widget.table),
            PSize.spacer.sizedBoxH,
            Row(
              children: [
                Expanded(
                  child: PButton(
                    label: context.i18n.descartar.toUpperCase(),
                    onPressed: () {
                      _canPop = true;
                      Navigator.of(context).pop(false);
                    },
                    color: context.color.errorColor,
                  ),
                ),
                PSize.spacer.sizedBoxW,
                Expanded(
                  child: PButton(
                    label: context.i18n.abrirMesa.toUpperCase(),
                    onPressed: () {
                      _canPop = true;
                      Navigator.of(context).pop(true);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
