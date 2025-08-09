import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app/l10n/l18n_extension.dart';

import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/order/order/aplication/stores/order_status_store.dart';
import 'package:app/src/modules/order/order/presenters/components/card_qrcode_data_local.dart';
import 'package:app/src/modules/order/order/presenters/components/data_customer_order.dart';
import 'package:app/src/modules/order/order/presenters/components/data_establishment_order.dart';
import 'package:app/src/modules/order/order/presenters/components/resume_order.dart';
import 'package:app/src/modules/order/order/presenters/components/status_schedule_order_component.dart';
import 'package:app/src/modules/order/order/presenters/components/step_time_expired.dart';
import 'package:app/src/modules/order/order/presenters/components/step_waiting.dart';
import 'package:app/src/modules/order/order/presenters/components/totals_order.dart';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class OrderPage extends StatefulWidget {
  final String? orderId;
  const OrderPage({super.key, this.orderId});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with WidgetsBindingObserver {
  late final store = context.read<OrderStatusStore>();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && store.needUpdate) {
      store.updateOrder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          return FutureState(
            future: store.init(widget.orderId!),
            onError: (context, error) => Center(child: Text(error.toString())),
            onComplete: (context, data) => Scaffold(
              appBar: AppBar(title: Text('${context.i18n.pedido} #${store.order.getOrderNumber}'), centerTitle: true),
              body: Builder(
                builder: (context) {
                  return Column(
                    children: [
                      ListenableBuilder(
                        listenable: store,
                        builder: (context, _) {
                          return Column(
                            children: [
                              PSize.ii.sizedBoxH,
                              if (store.order.status != OrderStatusEnum.losted && store.order.status != OrderStatusEnum.canceled) StepWaiting(store: store),
                              if (store.order.status == OrderStatusEnum.losted || store.order.status == OrderStatusEnum.canceled) StepTimeExpired(store: store, orderStatus: store.order.status),
                              PSize.ii.sizedBoxH,
                            ],
                          );
                        },
                      ),
                      Expanded(
                        child: CupertinoScrollbar(
                          thumbVisibility: true,
                          controller: scrollController,
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              children: [
                                DataEstablishmentOrder(establishment: store.establishment, orderType: store.order.orderType!),
                                PSize.ii.sizedBoxH,
                                if (store.order.isScheduling) StatusScheduleOrderComponent(store: store),
                                DataCustomerOrder(store: store),
                                PSize.ii.sizedBoxH,
                                Padding(
                                  padding: PSize.ii.paddingHorizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: CwOutlineButton(
                                          label: context.i18n.fazerUmNovoPedido.toUpperCase(),
                                          onPressed: () {
                                            Go.of(context).go(Routes.menu(establishmentId: store.establishment.id));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PSize.ii.sizedBoxH,
                                // if (store.showButtonClaim)
                                //   Column(
                                //     children: [
                                //       Sz.ii.sizedBoxH,
                                //       Padding(
                                //         padding: Sz.ii.paddingHorizontal,
                                //         child: Row(
                                //           mainAxisAlignment: MainAxisAlignment.center,
                                //           children: [
                                //             Expanded(
                                //                 child: CwButton(
                                //                     color: Colors.red,
                                //                     label: "any problem? make a claim".toUpperCase(),
                                //                     onPressed: () {
                                //                       Go.of(context).goNamed(Routes.claim.name, pathParameters: Params.orderId.buildParam(store.order.id));
                                //                     })),
                                //           ],
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                PSize.ii.sizedBoxH,
                                ResumeOrder(store: store),
                                PSize.ii.sizedBoxH,
                                TotalsOrder(store: store),
                                PSize.ii.sizedBoxH,
                                if (store.order.paymentType == PaymentType.pix) CardQrcodeDataLocal(store: store),
                                PSize.vii.sizedBoxH,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
