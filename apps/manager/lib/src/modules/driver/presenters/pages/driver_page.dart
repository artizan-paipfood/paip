import 'package:flutter/material.dart';

import 'package:multiavatar/multiavatar.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/base_page.dart';
import 'package:manager/src/core/components/container_shadow.dart';
import 'package:manager/src/core/components/header_card.dart';
import 'package:manager/src/modules/driver/domain/services/add_driver_service.dart';
import 'package:manager/src/modules/driver/presenters/components/dialog_add_driver.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DriverPage extends StatefulWidget {
  const DriverPage({super.key});

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  late final service = context.read<AddDriverService>();
  @override
  Widget build(BuildContext context) {
    return BasePage(
      header: CwHeaderCard(titleLabel: context.i18n.entregadores),
      child: ListenableBuilder(
        listenable: service,
        builder: (context, _) {
          return Row(
            children: [
              Expanded(
                child: CwContainerShadow(
                  child: ListView.builder(
                    itemCount: service.dataSource.deliveryMen.values.toList().length,
                    itemBuilder: (context, index) {
                      final driver = service.dataSource.deliveryMen.values.toList()[index];
                      return Padding(
                        padding: PSize.i.paddingBottom,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: context.color.neutral100, borderRadius: PSize.i.borderRadiusAll),
                          child: Padding(
                            padding: PSize.i.paddingVertical + PSize.ii.paddingHorizontal,
                            child: Row(
                              children: [
                                CircleAvatar(backgroundColor: context.color.onPrimaryBG, child: driver.user.name.isNotEmpty ? SvgPicture.string(multiavatar(driver.user.name)) : const SizedBox.shrink()),
                                PSize.ii.sizedBoxW,
                                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(driver.user.name), Text(driver.user.phone ?? " -- ", style: context.textTheme.bodyMedium?.muted(context))])),
                                Visibility(visible: driver.isAccepted, replacement: CwOutlineButton(label: context.i18n.pendente, onPressed: () {}), child: PButton(label: context.i18n.parceiro)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              PSize.ii.sizedBoxW,
              Expanded(
                child: CwContainerShadow(
                  child: Padding(
                    padding: PSize.i.paddingAll,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: PButton(
                            label: "ADICIONAR ENTREGADOR PARCEIRO",
                            icon: PaipIcons.add,
                            onPressed: () async {
                              final result = await showDialog(context: context, builder: (context) => const DialogAddDriver());
                              if (result != null && result) {
                                await service.loadDeleveryMen();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
