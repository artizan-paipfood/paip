import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';

class LayoutDialogDelete extends StatelessWidget {
  final void Function()? onDelete;
  const LayoutDialogDelete({
    super.key,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return CwDialog(
      title: Text(
        'Tem certeza que deseja excluir este layout?',
        style: context.textTheme.labelLarge,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: CwOutlineButton(
                label: 'Cancelar',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            PSize.spacer.sizedBoxW,
            Expanded(
              child: PButton(label: 'Excluir', onPressed: onDelete),
            ),
          ],
        )
      ],
    );
  }
}
