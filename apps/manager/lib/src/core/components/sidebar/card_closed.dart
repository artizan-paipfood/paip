import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/services/establishment_service.dart';
import 'package:manager/src/core/components/container_pulse.dart';
import 'package:manager/src/modules/home/presenters/home/components/dialog_sync_customers.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardClosed extends StatefulWidget {
  final EstablishmentService establishmentService;
  const CardClosed({required this.establishmentService, super.key});

  @override
  State<CardClosed> createState() => _CardClosedState();
}

class _CardClosedState extends State<CardClosed> {
  @override
  Widget build(BuildContext context) {
    return ContainerPulse(
      maxScale: 4.5,
      radius: 100,
      color: PColors.tertiaryDColor_,
      child: InkWell(
        hoverColor: Colors.white.withOpacity(0.3),
        borderRadius: PSize.i.borderRadiusAll,
        onTap: () async {
          await widget.establishmentService.openClose();
          await widget.establishmentService.verifySyncCustomer().then((update) {
            if (update && context.mounted) showDialog(context: context, builder: (context) => const DialogSyncCustomers());
          });
        },
        child: Ink(
          decoration: BoxDecoration(color: context.color.errorColor, borderRadius: PSize.i.borderRadiusAll),
          height: 50,
          width: 50,
          child: Center(child: FittedBox(child: Text(context.i18n.fechado, style: context.textTheme.labelSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)))),
        ),
      ),
    );
  }
}
