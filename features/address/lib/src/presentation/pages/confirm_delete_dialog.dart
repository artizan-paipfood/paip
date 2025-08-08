import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

Future<void> showConfirmDeleteDialog(BuildContext context, {required String title, required VoidCallback onConfirm, VoidCallback? onCancel}) {
  return showArtDialog(context: context, builder: (context) => ConfirmDeleteDialog(title: title, onConfirm: onConfirm, onCancel: onCancel));
}

class ConfirmDeleteDialog extends StatelessWidget {
  final String title;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const ConfirmDeleteDialog({required this.title, required this.onConfirm, required this.onCancel, super.key});

  @override
  Widget build(BuildContext context) {
    return ArtDialog(
      title: Text(title),
      actions: [
        ArtButton.secondary(
            child: Text('Cancelar'),
            onPressed: () {
              context.pop();
              onCancel?.call();
            }),
        PSize.iii.sizedBoxHW,
        ArtButton(
          child: Text('Excluir'),
          onPressed: () {
            onConfirm();
          },
        ),
      ],
      child: IntrinsicWidth(),
    );
  }
}
