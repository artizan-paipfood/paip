import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/pdv/aplication/stores/customer_store.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/customers/card_customers_details.dart';
import 'package:paipfood_package/paipfood_package.dart';

class TabCustomers extends StatelessWidget {
  final TabController tabController;
  const TabCustomers({required this.tabController, super.key});

  @override
  Widget build(BuildContext context) {
    late final store = context.read<CustomerStore>();
    final debounce = Debounce(milliseconds: 1000);
    return FutureState(
      future: store.init(),
      onComplete: (context, data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: PSize.iii.paddingAll,
            child: Column(
              children: [
                Text(context.i18n.selecioneClientePedido, style: context.textTheme.headlineLarge),
                PSize.ii.sizedBoxH,
                Row(
                  children: [
                    CwTextFormFild(
                      prefixIcon: const Icon(PIcons.strokeRoundedSearch01),
                      hintText: context.i18n.pesquiseClienteNomeTelefone,
                      expanded: true,
                      onChanged: (value) {
                        debounce.startTimer(
                          value: value,
                          onComplete: () {
                            store.getCustomersByNameOrPhone(nameOrPhone: value);
                          },
                          length: 2,
                        );
                        if (value.isEmpty) store.getAllCustomers();
                      },
                    ),
                    PSize.ii.sizedBoxW,
                    PButton(
                      label: context.i18n.adicionarCliente,
                      icon: PaipIcons.add,
                      onPressed: () {
                        store.selectedCustomer = null;
                        tabController.animateTo(store.infoCustomerTabPage);
                      },
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: store.rebuildListCustomers,
              builder: (context, _, __) {
                return ListView.builder(
                  itemCount: store.customers.length,
                  itemExtent: 120,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: PSize.iii.paddingHorizontal + 0.5.paddingVertical,
                      child: CardCustomerDetails(
                        customer: store.customers[index],
                        store: store,
                        tabController: tabController,
                        onTap: () {
                          store.selectedCustomer = store.customers[index];
                          tabController.animateTo(store.selectAddressTabPage);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
