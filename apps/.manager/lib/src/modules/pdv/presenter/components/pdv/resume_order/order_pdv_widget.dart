import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/pdv/aplication/stores/order_pdv_store.dart';
import 'package:manager/src/modules/pdv/domain/payment_pdv_dto.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/card_product_cart.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/customers/card_customer/card_customer_component.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/finish_order/end_drawer_finish_order.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/resume_order/order_type_pdv_widget.dart';
import 'package:paipfood_package/paipfood_package.dart';

class OrderPdvWidget extends StatefulWidget {
  final bool showDelivery;
  const OrderPdvWidget({super.key, this.showDelivery = true});

  @override
  State<OrderPdvWidget> createState() => _OrderPdvWidgetState();
}

class _OrderPdvWidgetState extends State<OrderPdvWidget> {
  late final store = context.read<OrderPdvStore>();
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        return Container(
          width: 300,
          decoration: BoxDecoration(borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)), color: context.color.primaryBG),
          child: Column(
            children: [
              if (widget.showDelivery)
                Column(
                  children: [
                    PSize.i.sizedBoxH,
                    DecoratedBox(decoration: BoxDecoration(color: context.color.onPrimaryBG, borderRadius: 0.5.borderRadiusAll), child: CardCustomerComponent(store: store, onDrawer: false, formKey: store.customerFormKey)),
                    PSize.i.sizedBoxH,
                    SizedBox(width: double.infinity, child: OrderTypePdvWidget(store: store)),
                  ],
                ),
              Expanded(
                child: Padding(
                  padding: PSize.i.paddingVertical,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: context.color.surface, borderRadius: PSize.i.borderRadiusAll),
                    child: ListView.builder(itemCount: store.order.cartProducts.length, itemBuilder: (context, index) => CardProductCart(cartProductVm: store.order.cartProducts[index])),
                  ),
                ),
              ),
              if (store.order.cartProducts.isNotEmpty)
                Padding(
                  padding: PSize.i.paddingBottom,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton.filled(color: Colors.white, icon: const Icon(PIcons.strokeRoundedCancel01), onPressed: () {}, style: IconButton.styleFrom(backgroundColor: context.color.errorColor)),
                      PSize.ii.sizedBoxW,
                      Expanded(
                        child: PButton(
                          label: '${context.i18n.finalizar} ${store.order.getCartAmount.toStringCurrency}'.toUpperCase(),
                          onPressed: () async {
                            if (widget.showDelivery == false) {
                              Loader.show(context);
                              await store.saveOrder();
                              Future.delayed(1.5.seconds, () => store.tableStore.notify());

                              Loader.hide();
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                              return;
                            }

                            if (store.customerFormKey.currentState?.validate() ?? true) {
                              Navigator.of(context).pop();
                              if (context.mounted) {
                                await showDialog(context: context, builder: (context) => EndDrawerFinishOrder(dto: PaymentPdvDto(order: store.order)));
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
