import 'package:flutter/material.dart';
import 'package:multiavatar/multiavatar.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/helpers/helpers.dart';
import 'package:manager/src/core/components/dialogs/dialog_delete.dart';
import 'package:manager/src/modules/pdv/aplication/stores/customer_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardCustomerDetails extends StatelessWidget {
  final CustomerModel customer;
  final CustomerStore? store;
  final TabController? tabController;
  final void Function()? onTap;
  const CardCustomerDetails({required this.customer, super.key, this.store, this.tabController, this.onTap});

  @override
  Widget build(BuildContext context) {
    final address = customer.addresses;

    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(color: context.color.primaryBG, borderRadius: 0.5.borderRadiusAll),
        child: Padding(
          padding: PSize.i.paddingAll,
          child: Column(
            children: [
              if (customer.lastOrderAt != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(_buildDescriptionQtyOrders(context, qty: customer.qtyOrders), style: context.textTheme.bodySmall?.muted(context)), Text('⏰ ${Helpers.lastPurchase(context, customer.lastOrderAt!)}', style: context.textTheme.bodySmall?.muted(context))],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(padding: PSize.i.paddingAll, child: CircleAvatar(radius: 30, backgroundColor: context.color.onPrimaryBG, child: customer.name.isNotEmpty ? SvgPicture.string(multiavatar(customer.name)) : const SizedBox.shrink())),
                  Text("${customer.name}\n${customer.phone}\n${customer.birthdate != null ? DateFormat("dd/MM/yyyy").format(customer.birthdate!) : "  /  /    "} 🎂", style: context.textTheme.bodySmall),
                  PSize.ii.sizedBoxW,
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(maxRadius: 12, backgroundColor: PColors.primaryColor_.withOpacity(0.2), child: const Icon(PaipIcons.location, size: 18, color: PColors.primaryColor_)),
                            PSize.i.sizedBoxW,
                            Expanded(child: Text(customer.address?.formattedAddress(LocaleNotifier.instance.locale) ?? '', style: context.textTheme.bodySmall)),
                            if (address.length > 1) CircleAvatar(maxRadius: 12, backgroundColor: context.color.tertiaryColor.withOpacity(0.2), child: Text("+${address.length - 1}", style: context.textTheme.bodySmall?.copyWith(color: context.color.tertiaryColor))),
                          ],
                        ),
                      ],
                      // textAlign: TextAlign.end,
                    ),
                  ),
                  PSize.i.sizedBoxW,
                  if (store != null)
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
                          label: context.i18n.editar,
                          icon: PaipIcons.edit,
                          onTap: () {
                            store?.selectedCustomer = customer;
                            tabController?.animateTo(store?.infoCustomerTabPage ?? 0);
                          },
                        ),
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
                                  await store?.deleteCustomer(customer);
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _buildDescriptionQtyOrders(BuildContext context, {required int qty}) {
    if (qty > 1) return '$qty ${context.i18n.pedidos}';
    return '$qty ${context.i18n.pedido}';
  }
}
