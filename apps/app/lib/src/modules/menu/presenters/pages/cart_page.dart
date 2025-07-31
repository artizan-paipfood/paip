import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app/l10n/l18n_extension.dart';

import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/menu/presenters/view_models/menu_viewmodel.dart';
import 'package:app/src/modules/menu/presenters/components/card_delivery_time.dart';
import 'package:app/src/modules/menu/presenters/components/card_name_phone_resume.dart';
import 'package:app/src/modules/menu/presenters/components/card_options_order_resume.dart';
import 'package:app/src/modules/menu/presenters/components/card_totals_resume.dart';
import 'package:app/src/modules/menu/presenters/components/card_product_cart.dart';
import 'package:app/src/modules/user/presenters/viewmodels/user_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final viewmodel = context.read<MenuViewmodel>();
  late final userStore = context.read<UserStore>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StateNotifier(
      stateNotifier: viewmodel.status,
      onLoad: (context) => const SizedBox.shrink(),
      onComplete: (context) {
        if (viewmodel.orderViewmodel.order.cartProducts.isEmpty) {
          Go.of(context).go(Routes.menu(establishmentId: viewmodel.establishment.id));
          return const SizedBox.shrink();
        }
        viewmodel.handleOrderType();
        return Scaffold(
          appBar: AppBar(leading: BackButton(onPressed: () => context.pop()), centerTitle: true, title: Text(context.i18n.resumoPedido)),
          body: ListenableBuilder(
            listenable: viewmodel.listenables,
            builder: (context, _) {
              return Column(
                children: [
                  Expanded(
                    child: CupertinoScrollbar(
                      thumbVisibility: true,
                      controller: scrollController,
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            Container(
                              color: context.color.primaryBG,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(context.i18n.itensPedido, style: context.textTheme.titleMedium),
                                    ...viewmodel.orderViewmodel.order.cartProducts.map((e) => CardProductCart(cartProductVm: e, onAction: () => viewmodel.notify())),
                                    Center(child: CwTextButton(label: context.i18n.adicionarMaisItens.toUpperCase(), icon: PIcons.strokeRoundedPlusSign, colorText: context.color.primaryColor, iconColor: context.color.primaryColor, onPressed: () => context.pop())),
                                  ],
                                ),
                              ),
                            ),
                            PSize.ii.sizedBoxH,
                            CardNamePhoneResume(menuViewmodel: viewmodel),
                            PSize.ii.sizedBoxH,
                            if (viewmodel.establishment.enableSchedule) Padding(padding: PSize.ii.paddingBottom, child: CardDeliveryTime(store: viewmodel)),
                            CardOptionsOrderResume(menuViewmodel: viewmodel, userStore: userStore),
                            PSize.ii.sizedBoxH,
                          ],
                        ),
                      ),
                    ),
                  ),
                  CardTotalsCart(viewmodel: viewmodel, userStore: userStore),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
