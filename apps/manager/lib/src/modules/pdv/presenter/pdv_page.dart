import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/base_page.dart';
import 'package:manager/src/core/components/button_hide_navbar_widget.dart';
import 'package:manager/src/core/components/header_card.dart';
import 'package:manager/src/core/components/sidebar/sidebar.dart';
import 'package:manager/src/modules/pdv/aplication/stores/menu_pdv_store.dart';
import 'package:manager/src/modules/pdv/aplication/stores/order_pdv_store.dart';
import 'package:manager/src/modules/pdv/presenter/components/card_table_pdv_widget.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/customers/dialog_update_customers.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/grid_products.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/list_selector_categories.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/resume_order/order_pdv_widget.dart';
import 'package:manager/src/modules/table/aplication/controllers/table_order_controller.dart';
import 'package:manager/src/modules/table/presenter/components/dialog_open_table.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PdvPage extends StatefulWidget {
  final bool isModal;
  const PdvPage({super.key, this.isModal = false});

  @override
  State<PdvPage> createState() => _PdvPageState();
}

class _PdvPageState extends State<PdvPage> {
  late final menuPdvStore = context.read<MenuPdvStore>();
  late final orderPdvStore = context.read<OrderPdvStore>();
  final phoneEC = TextEditingController();
  late final navController = SidebarController.instance;
  late final tableOrderController = context.read<TableOrderController>();

  void _verifyTable() {
    if (orderPdvStore.table != null && orderPdvStore.table!.isPendingOpen) {
      showDialog(
        context: context,
        builder: (ctx) => DialogOpenTable(
          table: orderPdvStore.table!,
          onPop: (value) async {
            Loader.show(ctx);
            if (value) {
              await tableOrderController.tableStore.turnTableToOccupied(orderPdvStore.table!);
              Loader.hide();
              return;
            }
            tableOrderController.tableStore.setSelectedTable(null);
            Loader.hide();
          },
        ),
      );
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _verifyTable();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureState(
        onError: (context, error) => Text(error.toString()),
        future: menuPdvStore.initialize(),
        onComplete: (context, data) => Row(
          children: [
            Expanded(
              child: BasePage(
                header: CwHeaderCard(
                  titleLabel: context.i18n.pdv,
                  actions: Row(
                    children: [
                      PSize.i.sizedBoxW,
                      ListenableBuilder(
                        listenable: orderPdvStore.tableStore,
                        builder: (context, _) {
                          if (orderPdvStore.tableStore.selectedTable == null) return const SizedBox.shrink();
                          return CardTablePdvWidget(
                            table: orderPdvStore.tableStore.selectedTable!,
                            onDiscartTable: () {
                              tableOrderController.discartTable(orderPdvStore.tableStore.selectedTable!);
                            },
                          );
                        },
                      ),
                      PSize.i.sizedBoxW,
                      IconButton.filled(
                        style: IconButton.styleFrom(backgroundColor: context.color.onPrimaryBG),
                        onPressed: () {
                          showDialog(context: context, builder: (context) => const DialogUpdateCustomers());
                        },
                        icon: const Icon(PIcons.strokeRoundedRefresh),
                        tooltip: context.i18n.sincronizarContatos,
                        color: context.color.primaryText,
                      ),
                    ],
                  ),
                  title: Row(
                    children: [
                      if (widget.isModal == false) ...[const ButtonHideNavbarWidget(), PSize.i.sizedBoxW],
                      CwTextFormFild(expanded: true, hintText: context.i18n.pesquisarProdutos, prefixIcon: const Icon(PIcons.strokeRoundedSearch01), onChanged: (value) => menuPdvStore.searchProducts(value)),
                    ],
                  ),
                ),
                child: const Row(
                  children: [
                    Expanded(child: Column(children: [ListSelectorCategories(), GridProducts()])),
                  ],
                ),
              ),
            ),
            ColoredBox(color: context.color.primaryBG, child: Padding(padding: PSize.i.paddingRight, child: OrderPdvWidget(showDelivery: orderPdvStore.table == null))),
          ],
        ),
      ),
    );
  }
}
