import 'package:flutter/cupertino.dart';

import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/menu/presenters/view_models/menu_viewmodel.dart';
import 'package:app/src/modules/menu/presenters/components/card_option_order_delivery.dart';
import 'package:app/src/modules/menu/presenters/components/card_option_order_takeway.dart';
import 'package:app/src/modules/user/presenters/viewmodels/user_store.dart';
import 'package:app/src/modules/user/domain/enums/user_navigation_mode.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ModalSelectOrderType extends StatefulWidget {
  final MenuViewmodel menuViewmodel;
  final UserStore userStore;

  const ModalSelectOrderType({super.key, required this.menuViewmodel, required this.userStore});

  @override
  State<ModalSelectOrderType> createState() => _ModalSelectOrderTypeState();
}

class _ModalSelectOrderTypeState extends State<ModalSelectOrderType> {
  @override
  Widget build(BuildContext context) {
    return CwModal(
      child: ListenableBuilder(
        listenable: widget.menuViewmodel,
        builder: (context, _) {
          return Padding(
            padding: PSize.ii.paddingHorizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.menuViewmodel.establishment.orderTypes.contains(OrderTypeEnum.delivery))
                  CardOptionOrderDelivery(
                    deliveryAreaPerMile: widget.menuViewmodel.dataEstablishment.deliveryAreaPerMile,
                    isSelected: (widget.menuViewmodel.orderType.isDelivery && AuthNotifier.instance.auth.user != null),
                    deliveryTax: widget.menuViewmodel.deliveryAreaNotifier.deliveryTax,
                    address: AuthNotifier.instance.auth.user?.getAddress,
                    onEdit: () {},
                    onTap: () {
                      context.pop();
                      widget.userStore
                        ..setNavigationMode(UserNavigationMode.loginDelivery)
                        ..setFinishRouteName(Routes.cart(establishmentId: widget.menuViewmodel.establishment.id))
                        ..initializeEstablishment(widget.menuViewmodel.establishment.address!);
                      context.push(Routes.searchAddress);
                    },
                  ),
                if (widget.menuViewmodel.establishment.orderTypes.contains(OrderTypeEnum.takeWay) && (widget.menuViewmodel.establishment.orderTypes.contains(OrderTypeEnum.delivery)))
                  Padding(
                    padding: PSize.ii.paddingHorizontal,
                    child: Row(
                      children: [
                        Expanded(child: Container(height: 1, color: context.color.neutral400)),
                        Padding(padding: PSize.i.paddingHorizontal, child: Text(context.i18n.ou, style: context.textTheme.titleMedium)),
                        Expanded(child: Container(height: 1, color: context.color.neutral400)),
                      ],
                    ),
                  ),
                if (widget.menuViewmodel.establishment.orderTypes.contains(OrderTypeEnum.takeWay))
                  CardOptionOrderTakeway(
                    isSelected: !widget.menuViewmodel.orderType.isDelivery,
                    establishmentAddress: widget.menuViewmodel.establishment.address,
                    userStore: widget.userStore,
                    onTap: () {
                      context.pop();
                      widget.menuViewmodel.setOrderType(OrderTypeEnum.takeWay);
                      context.read<UserStore>()
                        ..setNavigationMode(UserNavigationMode.loginPickup)
                        ..setFinishRouteName(Routes.cart(establishmentId: widget.menuViewmodel.establishment.id))
                        ..initializeEstablishment(widget.menuViewmodel.establishment.address!);

                      context.push(Routes.name);
                    },
                  ),
                PSize.v.sizedBoxH,
              ],
            ),
          );
        },
      ),
    );
  }
}
