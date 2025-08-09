import 'dart:io';

import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DialogResetSystem extends StatelessWidget {
  const DialogResetSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: Text(context.i18n.necessarioReiniciar),
        actions: [
          Row(children: [Expanded(child: PButton(label: context.i18n.fecharSistema, onPressed: () => exit(0)))]),
        ],
      ),
    );
  }
}
