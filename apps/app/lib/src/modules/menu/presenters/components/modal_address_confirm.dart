import 'package:flutter/material.dart';

import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/menu/presenters/view_models/menu_viewmodel.dart';
import 'package:app/src/modules/menu/presenters/components/card_option_order_delivery.dart';
import 'package:app/src/modules/user/presenters/viewmodels/user_store.dart';
import 'package:app/src/modules/user/domain/enums/user_navigation_mode.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ModalAddressConfirm extends StatefulWidget {
  final MenuViewmodel menuViewmodel;
  final UserStore userStore;

  const ModalAddressConfirm({required this.menuViewmodel, required this.userStore, super.key});

  @override
  State<ModalAddressConfirm> createState() => _ModalAddressConfirmState();
}

class _ModalAddressConfirmState extends State<ModalAddressConfirm> {
  @override
  Widget build(BuildContext context) {
    return CwModal(
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: PSize.iv.paddingBottom + PSize.ii.paddingHorizontal,
          child: Column(
            children: [
              Text(context.i18n.confirmeSeuEnderecoEntrega.toUpperCase(), style: context.textTheme.titleMedium),
              PSize.ii.sizedBoxH,
              CardOptionOrderDelivery(
                deliveryAreaPerMile: widget.menuViewmodel.dataEstablishment.deliveryAreaPerMile,
                isSelected: (widget.menuViewmodel.orderType.isDelivery && AuthNotifier.instance.auth.user != null),
                deliveryTax: widget.menuViewmodel.deliveryAreaNotifier.deliveryTax,
                address: AuthNotifier.instance.auth.user?.getAddress,
                onEdit: () {
                  _onEditAdrres(context);
                },
                onTap: () {},
              ),
              PSize.ii.sizedBoxH,
              Row(
                children: [
                  Expanded(
                    child: PButton(
                      label: context.i18n.confirmarEndereco.toUpperCase(),
                      onPressed: () {
                        context.pop(true);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onEditAdrres(BuildContext context) {
    context.pop(false);
    widget.userStore
      ..setNavigationMode(UserNavigationMode.editAddress)
      ..setFinishRouteName(Routes.cart(establishmentId: widget.menuViewmodel.establishment.id))
      ..initializeEstablishment(widget.menuViewmodel.establishment.address!);
    context.push(Routes.userAddresses);
  }
}
