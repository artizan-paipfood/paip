import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';

import 'package:paipfood_package/paipfood_package.dart';

class DialogDelete extends StatelessWidget {
  final String? title;
  final Widget? content;
  final Future Function()? onDelete;
  const DialogDelete({super.key, this.onDelete, this.title, this.content});

  @override
  Widget build(BuildContext context) {
    Future<void> submmit() async {
      final nav = Navigator.of(context);
      await onDelete?.call();
      nav.pop();
    }

    return CwDialog(
      title: Text(title ?? context.i18n.tituloConfirmacaoExclusao),
      content: content,
      actions: [
        Row(
          children: [
            Expanded(child: CwOutlineButton(label: context.i18n.cancelar.toUpperCase(), onPressed: () => Navigator.of(context).pop())),
            PSize.iii.sizedBoxW,
            Expanded(
              child: PButton(
                color: context.color.errorColor,
                label: context.i18n.sim.toUpperCase(),
                onPressedFuture: () async {
                  await submmit();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
