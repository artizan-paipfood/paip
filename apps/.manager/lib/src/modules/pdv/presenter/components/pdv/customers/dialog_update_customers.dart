import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/services/establishment_service.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DialogUpdateCustomers extends StatefulWidget {
  const DialogUpdateCustomers({super.key});

  @override
  State<DialogUpdateCustomers> createState() => _DialogUpdateCustomersState();
}

class _DialogUpdateCustomersState extends State<DialogUpdateCustomers> {
  bool _isLoad = false;
  late final establishmentService = context.read<EstablishmentService>();
  @override
  Widget build(BuildContext context) {
    return CwDialog(
      title: Text(context.i18n.sincronizarContatos),
      content: _isLoad ? const SizedBox(height: 50, child: Center(child: CircularProgressIndicator(strokeCap: StrokeCap.round))) : const SizedBox.shrink(),
      actions: [
        if (isDesktop)
          CwOutlineButton(
            label: context.i18n.fazerBackup.toUpperCase(),
            onPressed: () async {
              final nav = Navigator.of(context);
              setState(() {
                _isLoad = true;
              });
              await establishmentService.upsertCustomersBucket();
              if (context.mounted) {
                toast.showSucess(context.i18n.backupRealizado);
              }
              nav.pop();
            },
          ),
        PButton(
          label: context.i18n.importarContatos.toUpperCase(),
          icon: PaipIcons.download,
          onPressedFuture: () async {
            final nav = Navigator.of(context);
            setState(() {
              _isLoad = true;
            });
            await establishmentService.downloadCustomersJsonFile();
            if (context.mounted) {
              toast.showSucess(context.i18n.contatosImportados);
            }
            nav.pop();
          },
        ),
      ],
    );
  }
}
