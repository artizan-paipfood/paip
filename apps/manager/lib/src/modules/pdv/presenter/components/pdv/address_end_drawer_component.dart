import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/dialog_end_drawer.dart';
import 'package:manager/src/modules/pdv/aplication/stores/order_pdv_store.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/customers/pdv_customer_address_form.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AddressEndDrawerComponent extends StatelessWidget {
  const AddressEndDrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<OrderPdvStore>();
    return CwDialogEndDrawer(
      child: Padding(
        padding: PSize.iii.paddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${context.i18n.adicioneEnderecoEntrega}.", style: context.textTheme.headlineLarge),
            PSize.ii.sizedBoxH,
            PdvCustomerAddressForm(
              onSave: (address) async {
                final nav = Navigator.of(context);
                await store.addAddressCustomer(address);
                nav.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
