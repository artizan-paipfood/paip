import 'dart:async';

import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DialogAddTableAreaComponent extends StatefulWidget {
  final TableAreaModel? tableArea;
  final FutureOr Function(TableAreaModel tableArea)? addTableArea;
  const DialogAddTableAreaComponent({super.key, this.tableArea, this.addTableArea});

  @override
  State<DialogAddTableAreaComponent> createState() => _DialogAddTableAreaComponentState();
}

class _DialogAddTableAreaComponentState extends State<DialogAddTableAreaComponent> {
  late TableAreaModel _tableArea = widget.tableArea ?? TableAreaModel(id: uuid, establishmentId: establishmentProvider.value.id);
  final fomrKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CwDialog(
      title: Text(context.i18n.adicionarAmbiente),
      content: Form(key: fomrKey, child: CwTextFormFild(label: context.i18n.nomeAmbiente, onChanged: (value) => _tableArea = _tableArea.copyWith(name: value), maskUtils: MaskUtils.cRequired())),
      actions: [
        Row(
          children: [
            Expanded(
              child: PButton(
                label: context.i18n.salvar.toUpperCase(),
                onPressed: () async {
                  if (fomrKey.currentState!.validate()) {
                    await widget.addTableArea?.call(_tableArea);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
