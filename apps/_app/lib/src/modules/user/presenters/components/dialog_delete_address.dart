import 'package:flutter/material.dart';

import 'package:app/l10n/l18n_extension.dart';

import 'package:paipfood_package/paipfood_package.dart';

class DialogDeleteAddress extends StatelessWidget {
  final void Function() onDelete;
  const DialogDeleteAddress({required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.i18n.temCerteza),
      content: Text(context.i18n.queDesejaExcluirEsteEndereco),
      actions: [
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: PButton(
                    label: context.i18n.excluirEndereco,
                    onPressed: () {
                      onDelete.call();
                      context.pop();
                    },
                  ),
                ),
              ],
            ),
            PSize.spacer.sizedBoxH,
            Row(children: [Expanded(child: CwOutlineButton(label: context.i18n.cancelar, onPressed: () => context.pop()))]),
          ],
        ),
      ],
    );
  }
}
