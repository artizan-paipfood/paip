import 'dart:async';

import 'package:address/src/_i18n/gen/strings.g.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

Future<void> showConfirmDeleteDialog(BuildContext context, {required String title, required String description, required FutureOr Function() onConfirm, VoidCallback? onCancel}) {
  return showArtDialog(context: context, builder: (context) => ConfirmDeleteDialog(title: title, description: description, onConfirm: onConfirm, onCancel: onCancel));
}

class ConfirmDeleteDialog extends StatelessWidget {
  final String title;
  final String description;
  final FutureOr Function() onConfirm;
  final VoidCallback? onCancel;

  const ConfirmDeleteDialog({required this.title, required this.description, required this.onConfirm, required this.onCancel, super.key});

  @override
  Widget build(BuildContext context) {
    return ArtDialog(
      removeBorderRadiusWhenTiny: false,
      title: Text(title),
      description: Text(description),
      actions: [
        ArtButton(
          child: Text(t.excluir),
          onPressed: () async {
            await onConfirm();
            if (context.mounted) context.pop();
          },
        ),
      ],
      child: IntrinsicWidth(),
    );
  }
}
