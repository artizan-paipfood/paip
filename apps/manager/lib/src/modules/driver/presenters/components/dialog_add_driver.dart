import 'package:flutter/material.dart';

import 'package:multiavatar/multiavatar.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/driver/domain/services/add_driver_service.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DialogAddDriver extends StatefulWidget {
  const DialogAddDriver({super.key});

  @override
  State<DialogAddDriver> createState() => _DialogAddDriverState();
}

class _DialogAddDriverState extends State<DialogAddDriver> {
  late final service = context.read<AddDriverService>();
  String phone = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: SizedBox(width: 400, child: Text(context.i18n.solicitarParceria)),
      content: ListenableBuilder(
        listenable: service,
        builder: (context, _) {
          return buildSearchDriver(context);
        },
      ),
    );
  }

  Widget buildSearchDriver(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CwTextFormFild(prefixIcon: const Icon(PIcons.strokeRoundedSearch01), label: context.i18n.telefoneEntregador, onChanged: (value) => phone = value),
        PSize.spacer.sizedBoxH,
        Row(
          children: [
            Expanded(
              child: PButton(
                label: context.i18n.confirmar,
                onPressedFuture: () async {
                  final deliveryMen = await service.getDeliveryMenByEndPhone(phone);
                  service.setDrivers(deliveryMen);
                },
              ),
            ),
          ],
        ),
        PSize.ii.sizedBoxH,
        ...service.drivers.map(
          (driver) => ListTile(
            onTap: () async {},
            leading: CircleAvatar(backgroundColor: context.color.onPrimaryBG, child: driver.user.name.isNotEmpty ? SvgPicture.string(multiavatar(driver.user.name)) : const SizedBox.shrink()),
            isThreeLine: true,
            trailing: CwOutlineButton(
              label: context.i18n.solicitarParceria.toUpperCase(),
              onPressed: () async {
                Loader.show(context);
                try {
                  await service.sendInvite(driver);
                  if (context.mounted) {
                    Navigator.of(context).pop(true);
                  }
                } catch (e) {
                  toast.showError(e.toString());
                } finally {
                  Loader.hide();
                }
              },
            ),
            title: Text(driver.user.name),
            subtitle: Text(driver.user.phone ?? "", style: context.textTheme.bodyMedium?.muted(context)),
          ),
        ),
      ],
    );
  }
}
