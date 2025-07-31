import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/modules/order/order/aplication/stores/order_status_store.dart';
import 'package:app/src/modules/order/order/presenters/components/data_establishment_order_claim.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ClaimPage extends StatefulWidget {
  final String? orderId;
  const ClaimPage({super.key, this.orderId});

  @override
  State<ClaimPage> createState() => _ClaimPageState();
}

class _ClaimPageState extends State<ClaimPage> with WidgetsBindingObserver {
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
    return ListenableBuilder(
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
                        return Column(children: [PSize.ii.sizedBoxH]);
                      },
                    ),
                    Expanded(child: CupertinoScrollbar(thumbVisibility: true, controller: scrollController, child: SingleChildScrollView(controller: scrollController, child: Column(children: [DataEstablishmentOrderClaim(store: store), PSize.ii.sizedBoxH])))),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
