import 'package:flutter/material.dart';

import 'package:manager/src/core/services/real_time/update_queus_realtime_service.dart';
import 'package:manager/src/modules/order/presenter/components/dialog_pdv.dart';
import 'package:manager/src/modules/order/presenter/components/header_orders_page_view_component.dart';
import 'package:manager/src/modules/order/presenter/orders_page_view.dart';
import 'package:manager/src/modules/table/aplication/stores/order_command_store.dart';
import 'package:manager/src/modules/table/aplication/stores/table_store.dart';
import 'package:manager/src/modules/table/presenter/components/order_command_view_component.dart';
import 'package:manager/src/modules/table/presenter/table_page.dart';
import 'package:paipfood_package/paipfood_package.dart';

enum PageViewOrders {
  orders(0),
  tables(1),
  command(2);

  final int pageIndex;

  const PageViewOrders(this.pageIndex);
}

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with WidgetsBindingObserver {
  late final updateQueusRealtimeService = context.read<UpdateQueusRealtimeService>();
  final pageController = PageController();
  ValueNotifier<PageViewOrders> pageViewOrders = ValueNotifier(PageViewOrders.orders);
  late final storeOrderSheet = context.read<OrderCommandStore>();
  late final tableStore = context.read<TableStore>();

  @override
  void initState() {
    updateQueusRealtimeService.verifyReconnect();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      updateQueusRealtimeService.verifyReconnect();
    }
  }

  void _changePage(PageViewOrders pageViewOrder) {
    pageController.animateToPage(pageViewOrder.pageIndex, duration: 500.milliseconds, curve: Curves.easeInOut);
    pageViewOrders.value = pageViewOrder;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ValueListenableBuilder(
              valueListenable: pageViewOrders,
              builder: (context, page, _) {
                return HeaderOrdersPageViewComponent(
                  selectedPage: page,
                  onTapOrders: () => _changePage(PageViewOrders.orders),
                  onTapTables: () => _changePage(PageViewOrders.tables),
                  onTapCommand: () => _changePage(PageViewOrders.command),
                  onSale: () {
                    tableStore.setSelectedTable(null);
                    showDialog(
                      context: context,
                      builder: (context) => const DialogPdv(),
                    );
                  },
                  // 🚀 PASSANDO O SERVIÇO REAL-TIME PARA O HEADER
                  realtimeService: updateQueusRealtimeService,
                );
              }),
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                OrdersPageView(orderRealTimeService: updateQueusRealtimeService),
                TablePage(
                  store: tableStore,
                ),
                OrderCommandViewComponent(store: storeOrderSheet)
              ],
            ),
          )
        ],
      ),
    );
  }
}
