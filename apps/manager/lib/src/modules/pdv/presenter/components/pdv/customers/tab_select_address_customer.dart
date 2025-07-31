import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/pdv/aplication/stores/customer_store.dart';
import 'package:manager/src/modules/pdv/aplication/stores/order_pdv_store.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/customers/card_address_client.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/customers/card_customers_details.dart';
import 'package:paipfood_package/paipfood_package.dart';

class TabSelectAddressCustomer extends StatefulWidget {
  final CustomerStore store;
  final TabController tabController;
  const TabSelectAddressCustomer({required this.store, required this.tabController, super.key});

  @override
  State<TabSelectAddressCustomer> createState() => _TabSelectAddressCustomerState();
}

class _TabSelectAddressCustomerState extends State<TabSelectAddressCustomer> {
  late final orderPdvStore = context.read<OrderPdvStore>();
  late final store = context.read<CustomerStore>();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: store.rebuildCustomer,
      builder: (context, _, __) {
        return Column(
          children: [
            Padding(padding: PSize.iii.paddingAll, child: Column(children: [Text(context.i18n.selecioneEnderecoPadraoCliente, style: context.textTheme.headlineLarge), PSize.ii.sizedBoxH, CardCustomerDetails(customer: widget.store.selectedCustomer!)])),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: PSize.iii.paddingRight,
                        child: PButton(
                          label: context.i18n.adicionarEndereco,
                          icon: PaipIcons.add,
                          onPressed: () {
                            widget.tabController.animateTo(widget.store.infoCustomerTabPage);
                          },
                        ),
                      ),
                    ),
                    PSize.ii.sizedBoxH,
                    ...widget.store.selectedCustomer!.addresses.map(
                      (address) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: PSize.iii.value),
                        child: CardAddressClient(
                          address: address,
                          customer: widget.store.selectedCustomer!,
                          store: store,
                          onTap: () {
                            setState(() {
                              widget.store.saveCustomer(widget.store.selectedCustomer!);
                              orderPdvStore
                                ..setCustomer(customer: widget.store.selectedCustomer!, address: address)
                                ..switchOrderType(OrderTypeEnum.delivery)
                                ..setDeliveryArea(widget.store.selectedCustomer!.address!);

                              Navigator.of(context).pop();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: PSize.ii.paddingVertical + PSize.iii.paddingHorizontal,
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CwOutlineButton(
                      label: context.i18n.retirada_consumo.toUpperCase(),
                      onPressed: () {
                        orderPdvStore
                          ..setCustomer(customer: widget.store.selectedCustomer!)
                          ..switchOrderType(OrderTypeEnum.consume);
                        Navigator.of(context).pop();
                      },
                    ),
                    PSize.ii.sizedBoxW,
                    PButton(
                      label: context.i18n.entrega,
                      color: context.color.neutral950,
                      colorText: context.color.neutral50,
                      onPressed: () {
                        if (widget.store.selectedCustomer!.address == null) {
                          toast.showInfo(context.i18n.infoSelecioneOuAdicioneEndereco);
                          return;
                        }
                        orderPdvStore
                          ..setCustomer(customer: widget.store.selectedCustomer!, address: widget.store.selectedCustomer!.address)
                          ..switchOrderType(OrderTypeEnum.delivery)
                          ..setDeliveryArea(widget.store.selectedCustomer!.address!);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
