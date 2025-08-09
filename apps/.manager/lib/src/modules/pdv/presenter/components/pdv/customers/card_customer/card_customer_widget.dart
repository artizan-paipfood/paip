import 'package:flutter/material.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:manager/src/modules/pdv/aplication/stores/order_pdv_store.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/resume_order/card_address_order.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardCustomerWidget extends StatelessWidget {
  final OrderPdvStore store;
  const CardCustomerWidget({
    required this.store,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final customer = store.customer;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: PSize.i.paddingAll,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: context.color.onPrimaryBG,
                    child: customer.name.isNotEmpty
                        ? SvgPicture.string(multiavatar(
                            customer.name,
                          ))
                        : const SizedBox.shrink(),
                  ),
                ),
                Text("${customer.name}\n${customer.phone}\n${customer.birthdate != null ? DateFormat("dd/MM/yyyy").format(customer.birthdate!) : "  /  /    "} 🎂"),
                PSize.ii.sizedBoxW,
              ],
            ),
            IconButton(
                onPressed: () {
                  store.setSingleCustomer();
                },
                icon: Icon(
                  PaipIcons.close,
                  color: context.color.errorColor,
                ))
          ],
        ),
        if (store.customer.address != null && store.order.orderType == OrderTypeEnum.delivery) //
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: CardAddressOrder(store: store),
          ),
      ],
    );
  }
}
