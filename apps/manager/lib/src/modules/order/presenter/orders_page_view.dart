import 'dart:ui';
import 'package:artizan_ui/artizan_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/order/aplication/stores/order_store.dart';
import 'package:manager/src/core/services/real_time/update_queus_realtime_service.dart';
import 'package:manager/src/modules/order/presenter/components/list_orders.dart';
import 'package:manager/src/modules/order/presenter/components/order_config_component.dart';
import 'package:paipfood_package/paipfood_package.dart';

class OrdersPageView extends StatefulWidget {
  final UpdateQueusRealtimeService orderRealTimeService;
  const OrdersPageView({required this.orderRealTimeService, super.key});

  @override
  State<OrdersPageView> createState() => _OrdersPageViewState();
}

class _OrdersPageViewState extends State<OrdersPageView> {
  late final store = context.read<OrderStore>();
  final scrollController = ScrollController();
  final MenuController controller = MenuController();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        return FutureState(
          onError: (context, error) => Text(error.toString()),
          future: store.init(),
          onComplete: (context, data) => Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
            floatingActionButton: ListenableBuilder(
              listenable: scrollController,
              builder: (context, _) {
                if (scrollController.offset < 150) return const SizedBox.shrink();
                return FloatingActionButton.small(
                  backgroundColor: context.color.tertiaryColor,
                  onPressed: () {
                    scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                  },
                  child: const Icon(Icons.arrow_back, color: Colors.black),
                );
              },
            ),
            body: Column(
              children: [
                Padding(
                  padding: PSize.ii.paddingHorizontal + PSize.i.paddingTop,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [SizedBox(width: 400, child: ArtTextFormField(placeholder: Text(context.i18n.buscarPedidos), trailing: const Icon(PIcons.strokeRoundedSearch01))), OrderConfigComponent(store: store)]),
                ),
                PSize.i.sizedBoxH,
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: CupertinoScrollbar(
                      thumbVisibility: true,
                      controller: scrollController,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ValueListenableBuilder(
                                valueListenable: store.rebuilPedings,
                                builder: (context, _, __) {
                                  return ListOrders(label: context.i18n.pendentes, store: store, color: context.color.tertiaryColor, orders: store.pedings.values.toList(), isExpanded: true);
                                },
                              ),
                              ValueListenableBuilder(
                                valueListenable: store.rebuildAccepteds,
                                builder: (context, _, __) {
                                  return ListOrders(label: context.i18n.emProducao, store: store, color: context.color.secondaryColor, orders: store.accepteds.values.toList());
                                },
                              ),
                              ValueListenableBuilder(
                                valueListenable: store.rebuildInDeliveries,
                                builder: (context, _, __) {
                                  return ListOrders(label: context.i18n.emRota_aguardandoRetirada, store: store, color: PColors.primaryColor_, orders: store.inDeliveries.values.toList());
                                },
                              ),
                              ValueListenableBuilder(
                                valueListenable: store.rebuildDelivereds,
                                builder: (context, _, __) {
                                  return ListOrders(label: context.i18n.concluidos, store: store, color: PColors.primaryColor_, orders: store.delivereds.values.toList());
                                },
                              ),
                              ValueListenableBuilder(
                                valueListenable: store.rebuildCanceleds,
                                builder: (context, _, __) {
                                  return ListOrders(label: context.i18n.cancelados, store: store, color: PColors.errorColorD_, orders: store.canceleds.values.toList());
                                },
                              ),
                              ValueListenableBuilder(
                                valueListenable: store.rebuildLosteds,
                                builder: (context, _, __) {
                                  return ListOrders(label: context.i18n.perdidos, store: store, color: context.color.neutral500, orders: store.losteds.values.toList());
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
