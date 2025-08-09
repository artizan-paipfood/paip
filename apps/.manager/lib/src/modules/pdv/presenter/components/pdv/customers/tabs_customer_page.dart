import 'package:flutter/material.dart';

import 'package:manager/src/modules/pdv/aplication/stores/customer_store.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/customers/tab_customers.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/customers/tab_info_customer.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/customers/tab_select_address_customer.dart';
import 'package:paipfood_package/paipfood_package.dart';

class TabsCustomerPage extends StatefulWidget {
  final int? initialPage;
  const TabsCustomerPage({
    super.key,
    this.initialPage,
  });

  @override
  State<TabsCustomerPage> createState() => _TabsCustomerPageState();
}

class _TabsCustomerPageState extends State<TabsCustomerPage> with TickerProviderStateMixin {
  late final store = context.read<CustomerStore>();
  late final TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    if (widget.initialPage != null) tabController.animateTo(widget.initialPage!);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            TabCustomers(tabController: tabController),
            TabSelectAddressCustomer(
              tabController: tabController,
              store: store,
            ),
            TabInfoCustomer(
              tabController: tabController,
              onCancel: () {
                tabController.animateTo(store.customersTabPage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
