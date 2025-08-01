import 'dart:async';

import 'package:flutter/material.dart';

import 'package:app/l10n/l18n_extension.dart';

import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/order/order/aplication/stores/order_status_store.dart';
import 'package:app/src/modules/order/order/presenters/components/data_establishment_order.dart';
import 'package:app/src/modules/order/order/presenters/components/totals_order.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:ui/p_linear_progess_indicator.dart';
import "package:universal_html/html.dart" as html;

class WaitingPaymentPage extends StatefulWidget {
  final String orderId;
  const WaitingPaymentPage({super.key, required this.orderId});

  @override
  State<WaitingPaymentPage> createState() => _WaitingPaymentPageState();
}

class _WaitingPaymentPageState extends State<WaitingPaymentPage> {
  late final store = context.read<OrderStatusStore>();

  bool get isAvaliable => store.order.expired == false;
  late bool stopUpdateOrder = isAvaliable;
  bool get isPaid => store.order.isPaid;
  Timer? timer;

  late Future<Status> _initialize;

  Future<Status> _init() async {
    await store.init(widget.orderId);
    return Status.complete;
  }

  @override
  void initState() {
    _initialize = _init();
    _updateOrder();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  _updateOrder() async {
    timer?.cancel();
    timer = Timer.periodic(20.seconds, (timer) async {
      if (stopUpdateOrder == false) {
        await store.updateOrder();
        _updateOrder();
        if (isAvaliable == false) {
          stopUpdateOrder = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureState(
      future: _initialize,
      onComplete: (context, data) => ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          if (isPaid) {
            Go.of(context).goNeglect(Routes.paymentSucess(orderId: widget.orderId));
          }
          return Scaffold(
            appBar: AppBar(automaticallyImplyLeading: false, title: Text(isAvaliable ? context.i18n.aguardandoPagamento.toUpperCase() : context.i18n.pedidoCancelado.toUpperCase())),
            body: Column(
              children: [
                if (isAvaliable)
                  Container(decoration: BoxDecoration(color: context.color.primaryBG), child: Padding(padding: PSize.i.paddingAll, child: Column(children: [PSize.i.sizedBoxH, const PLinearLinearProgessIndicatorWidget(load: true, color: Colors.amber), PSize.i.sizedBoxH]))),
                DataEstablishmentOrder(establishment: store.establishment, orderType: store.order.orderType!),
                Container(
                  decoration: BoxDecoration(color: context.color.primaryBG),
                  child: Padding(
                    padding: PSize.i.paddingAll,
                    child: Column(
                      children: [
                        PSize.i.sizedBoxH,
                        Row(
                          children: [
                            Expanded(child: Row(children: [CircleAvatar(backgroundColor: context.color.black, radius: 15, child: const Icon(PIcons.strokeRoundedUser, size: 18, color: Colors.white)), PSize.i.sizedBoxW, Text(store.order.customer.name)])),
                            if (store.order.timeLimitFormated != null)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  StreamBuilder(
                                    stream: Stream.periodic(1.seconds),
                                    builder: (context, _) {
                                      return Text(store.order.regressivePaymentTimeCounterFormatted);
                                    },
                                  ),
                                  PSize.i.sizedBoxW,
                                  Icon(PIcons.strokeRoundedAlarmClock, size: 18, color: context.color.black).animate(onPlay: (controller) => controller.repeat()).shake().then().shake(),
                                ],
                              ),
                          ],
                        ),
                        PSize.i.sizedBoxH,
                      ],
                    ),
                  ),
                ),
                TotalsOrder(store: store),
                PSize.spacer.sizedBoxH,
                if (isAvaliable)
                  Padding(
                    padding: PSize.ii.paddingHorizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: PButton(
                            color: context.color.black,
                            colorText: context.color.white,
                            label: context.i18n.pagar.toUpperCase(),
                            onPressed: () {
                              html.window.location.href = store.order.charge!.metadata['session_url']!;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                const Spacer(),
                Padding(
                  padding: PSize.ii.paddingHorizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CwOutlineButton(
                          label: context.i18n.fazerUmNovoPedido.toUpperCase(),
                          onPressed: () {
                            Go.of(context).goNeglect(Routes.menu(establishmentId: store.establishment.id));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if (isAvaliable && isPaid == false)
                  Column(
                    children: [
                      PSize.spacer.sizedBoxH,
                      Padding(
                        padding: PSize.ii.paddingHorizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CwTextButton(
                                label: context.i18n.cancelar.toUpperCase(),
                                onPressed: () {
                                  Go.of(context).go(Routes.menu(establishmentId: store.establishment.id));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                PSize.iii.sizedBoxH,
              ],
            ),
          );
        },
      ),
    );
  }
}
