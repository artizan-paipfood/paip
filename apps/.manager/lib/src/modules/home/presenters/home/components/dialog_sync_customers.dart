import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/services/establishment_service.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DialogSyncCustomers extends StatefulWidget {
  const DialogSyncCustomers({super.key});

  @override
  State<DialogSyncCustomers> createState() => _DialogSyncCustomersState();
}

class _DialogSyncCustomersState extends State<DialogSyncCustomers> {
  bool _isLoad = false;
  late final establishmentService = context.read<EstablishmentService>();
  @override
  Widget build(BuildContext context) {
    return CwDialog(
      title: const Text("Deseja fazer o backup dos seus clientes?"),
      content: _isLoad ? const SizedBox(height: 50, child: Center(child: CircularProgressIndicator(strokeCap: StrokeCap.round))) : const SizedBox.shrink(),
      actions: [
        CwOutlineButton(
          label: context.i18n.cancelar,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        PButton(
          label: context.i18n.sincronizar,
          onPressedFuture: () async {
            try {
              final nav = Navigator.of(context);
              setState(() {
                _isLoad = true;
              });
              await establishmentService.upsertCustomersBucket();
              if (context.mounted) {
                toast.showSucess(context.i18n.backupRealizado);
              }
              nav.pop();
            } catch (e) {
              setState(() {
                _isLoad = false;
              });
              toast.showError(e.toString());
            }
          },
        ),
      ],
    );
  }
}
