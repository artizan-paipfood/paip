import 'package:flutter/material.dart';
import 'package:manager/src/modules/pdv/aplication/stores/order_pdv_store.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/address_end_drawer_component.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/tag_widget_button.dart';
import 'package:paipfood_package/paipfood_package.dart';

class OrderTypePdvWidget extends StatelessWidget {
  final OrderPdvStore store;
  const OrderTypePdvWidget({
    required this.store,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.color.onPrimaryBG,
        borderRadius: 0.5.borderRadiusAll,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TagWidgetButton(
                label: OrderTypeEnum.consume.i18nText.toUpperCase(),
                isSelected: store.order.orderType == OrderTypeEnum.consume,
                onTap: () {
                  store.switchOrderType(OrderTypeEnum.consume);
                  return;
                },
              ),
              PSize.ii.sizedBoxW,
              TagWidgetButton(
                label: "${OrderTypeEnum.delivery.i18nText.toUpperCase()}${store.order.deliveryTax > 0 ? " - ${store.order.deliveryTax.toStringCurrency}" : ''}",
                isSelected: store.order.orderType == OrderTypeEnum.delivery,
                onTap: () {
                  if (store.order.customer.address != null) {
                    store.switchOrderType(OrderTypeEnum.delivery);
                    return;
                  }
                  showDialog(
                    context: context,
                    builder: (context) => const AddressEndDrawerComponent(),
                  );
                },
              ),
              PSize.ii.sizedBoxW,
              TagWidgetButton(
                label: OrderTypeEnum.takeWay.i18nText.toUpperCase(),
                isSelected: store.order.orderType == OrderTypeEnum.takeWay,
                onTap: () {
                  store.switchOrderType(OrderTypeEnum.takeWay);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
