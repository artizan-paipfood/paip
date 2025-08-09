import 'package:flutter/material.dart';

import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/menu/presenters/components/base_card_menu.dart';
import 'package:app/src/modules/menu/presenters/components/card_option_order_delivery.dart';
import 'package:app/src/modules/menu/presenters/components/card_option_order_takeway.dart';
import 'package:app/src/modules/user/presenters/viewmodels/user_store.dart';
import 'package:app/src/modules/user/domain/enums/user_navigation_mode.dart';
import 'package:paipfood_package/paipfood_package.dart';

import '../view_models/menu_viewmodel.dart';

class CardOptionsOrderResume extends StatelessWidget {
  final MenuViewmodel menuViewmodel;
  final UserStore userStore;
  const CardOptionsOrderResume({super.key, required this.menuViewmodel, required this.userStore});

  @override
  Widget build(BuildContext context) {
    return BaseCardMenu(
      children: [
        Text(context.i18n.comoDesejaReceberSeuPedido, style: context.textTheme.titleMedium),
        PSize.i.sizedBoxH,
        Padding(
          padding: PSize.i.paddingHorizontal,
          child: ListenableBuilder(
            listenable: menuViewmodel.listenables,
            builder: (context, _) {
              return Column(
                children: [
                  if (menuViewmodel.establishment.orderTypes.contains(OrderTypeEnum.delivery))
                    CardOptionOrderDelivery(
                      deliveryAreaPerMile: menuViewmodel.dataEstablishment.deliveryAreaPerMile,
                      isSelected: (menuViewmodel.orderType.isDelivery && AuthNotifier.instance.auth.user != null),
                      deliveryTax: menuViewmodel.deliveryAreaNotifier.deliveryTax,
                      address: AuthNotifier.instance.auth.user?.getAddress,
                      onEdit: () {
                        _onEditAdrres(context);
                        context.push(Routes.userAddresses);
                      },
                      onTap: () {
                        if (menuViewmodel.deliveryAreaNotifier.deliveryTax == null) {
                          _onEditAdrres(context);
                          if (AuthNotifier.instance.auth.user?.addresses.isNotEmpty == true) {
                            context.push(Routes.userAddresses);
                          } else {
                            context.push(Routes.searchAddress);
                          }
                          return;
                        }

                        menuViewmodel.setOrderType(OrderTypeEnum.delivery);
                      },
                    ),
                  PSize.i.sizedBoxH,
                  if (menuViewmodel.establishment.orderTypes.contains(OrderTypeEnum.takeWay))
                    CardOptionOrderTakeway(
                      isSelected: menuViewmodel.orderType.isTakeWay,
                      establishmentAddress: menuViewmodel.establishment.address,
                      userStore: userStore,
                      onTap: () {
                        menuViewmodel.setOrderType(OrderTypeEnum.takeWay);
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  void _onEditAdrres(BuildContext context) {
    userStore
      ..setNavigationMode(UserNavigationMode.editAddress)
      ..setFinishRouteName(Routes.cart(establishmentId: menuViewmodel.establishment.id))
      ..initializeEstablishment(menuViewmodel.establishment.address!);
  }
}
