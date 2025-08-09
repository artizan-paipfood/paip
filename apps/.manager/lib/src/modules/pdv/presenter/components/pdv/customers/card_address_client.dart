import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/dialogs/dialog_delete.dart';
import 'package:manager/src/modules/pdv/aplication/stores/customer_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardAddressClient extends StatelessWidget {
  final AddressEntity address;
  final CustomerModel customer;
  final void Function() onTap;
  final CustomerStore store;

  const CardAddressClient({required this.address, required this.customer, required this.onTap, required this.store, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSelected = customer.address?.lat == address.lat;
    return InkWell(
      borderRadius: PSize.i.borderRadiusAll,
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(color: isSelected ? PColors.primaryColor_ : context.color.primaryBG, borderRadius: PSize.i.borderRadiusAll),
        child: Padding(
          padding: PSize.i.paddingAll,
          child: Row(
            children: [
              CircleAvatar(maxRadius: 23, backgroundColor: isSelected ? PColors.neutral_.get50.withOpacity(0.2) : PColors.primaryColor_.withOpacity(0.2), child: Icon(PaipIcons.location, size: 30, color: isSelected ? PColors.neutral_.get50 : PColors.primaryColor_)),
              PSize.iii.sizedBoxW,
              Expanded(child: Text(address.formattedAddress(LocaleNotifier.instance.locale), style: context.textTheme.bodyMedium?.copyWith(color: isSelected ? PColors.neutral_.get50 : null))),
              if (isWindows)
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  elevation: 5,
                  tooltip: "",
                  color: context.color.surface,
                  surfaceTintColor: context.color.surface,
                  offset: const Offset(80, 0),
                  itemBuilder: (ctx) => [
                    CwPopMenuItem.icon(
                      context,
                      label: context.i18n.deletar,
                      icon: PaipIcons.trash,
                      iconColor: context.color.errorColor,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => DialogDelete(
                            onDelete: () async {
                              await store.deleteAddress(address: address, customer: customer);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
