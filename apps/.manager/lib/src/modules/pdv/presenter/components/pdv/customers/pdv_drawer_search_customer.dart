import 'package:flutter/material.dart';

import 'package:manager/src/core/components/dialog_end_drawer.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/customers/tabs_customer_page.dart';

class PdvDrawerSearchCustomer extends StatelessWidget {
  final int? initialPage;
  const PdvDrawerSearchCustomer({
    super.key,
    this.initialPage,
  });

  @override
  Widget build(BuildContext context) {
    return CwDialogEndDrawer(
      child: TabsCustomerPage(initialPage: initialPage),
    );
  }
}
