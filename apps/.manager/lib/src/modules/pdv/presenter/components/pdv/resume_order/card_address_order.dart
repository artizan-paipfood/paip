import 'package:flutter/material.dart';

import 'package:manager/src/modules/pdv/aplication/stores/customer_store.dart';
import 'package:manager/src/modules/pdv/aplication/stores/order_pdv_store.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/customers/pdv_drawer_search_customer.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/address_end_drawer_component.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardAddressOrder extends StatelessWidget {
  final OrderPdvStore store;

  const CardAddressOrder({
    required this.store,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PSize.i.sizedBoxW,
        Icon(
          PaipIcons.location,
          size: 20,
          color: PColors.primaryColor_,
        ),
        PSize.i.sizedBoxW,
        Expanded(child: Text(store.customer.address?.formattedAddress(LocaleNotifier.instance.locale) ?? "-")),
        IconButton(
          style: IconButton.styleFrom(),
          icon: const Icon(PIcons.strokeRoundedEdit02, size: 20),
          onPressed: () {
            if (store.customer.isSingleCustomer) {
              showDialog(
                context: context,
                builder: (context) => const AddressEndDrawerComponent(),
              );
              return;
            }
            final pageIndex = context.read<CustomerStore>().selectAddressTabPage;
            showDialog(context: context, builder: (context) => PdvDrawerSearchCustomer(initialPage: pageIndex));
          },
        )
      ],
    );
  }
}
