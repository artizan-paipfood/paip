import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/core/errors/generic_error.dart';
import 'package:app/src/modules/menu/presenters/components/modal_address_confirm.dart';
import 'package:app/src/modules/menu/presenters/components/modal_payment.dart';
import 'package:app/src/modules/user/presenters/viewmodels/user_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

import '../view_models/menu_viewmodel.dart';

class CardTotalsCart extends StatelessWidget {
  final MenuViewmodel viewmodel;
  final UserStore userStore;
  const CardTotalsCart({super.key, required this.viewmodel, required this.userStore});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.color.primaryBG,
        boxShadow: [
          BoxShadow(color: context.isDarkTheme ? Colors.black : Colors.black.withOpacity(0.2), blurRadius: 38, spreadRadius: 0, offset: const Offset(19, 0)),
          BoxShadow(color: context.isDarkTheme ? Colors.black : Colors.black.withOpacity(0.2), blurRadius: 12, spreadRadius: 0, offset: const Offset(15, 0)),
        ],
      ),
      child: Padding(
        padding: PSize.i.paddingHorizontal,
        child: Column(
          children: [
            PSize.i.sizedBoxH,
            Padding(
              padding: PSize.i.paddingHorizontal,
              child: Column(
                children: [
                  _buildRowEdit(context, label: context.i18n.subtota, value: viewmodel.orderViewmodel.order.getCartAmount),
                  _buildRowEdit(context, label: Utils.capitalizeWords(context.i18n.taxaEntrega), value: viewmodel.getDeliveryTax),
                  _buildRowEdit(context, label: context.i18n.desconto, value: viewmodel.orderViewmodel.order.discount, isNegative: true),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(context.i18n.total.toUpperCase(), style: context.textTheme.titleMedium), Text(viewmodel.getTotal.toStringCurrency, style: context.textTheme.titleMedium)]),
                  PSize.ii.sizedBoxH,
                  Row(
                    children: [
                      Expanded(
                        child: PButton(
                          label: context.i18n.escolherFormaPagamento.toUpperCase(),
                          onPressed: () async {
                            try {
                              await viewmodel.validateOrderRules(context);
                            } catch (e) {
                              if (e is GenericError) {
                                return banner.showError(e.message);
                              }
                              return banner.showError(e.toString());
                            }

                            bool navigatePayment = true;
                            if (context.mounted && !viewmodel.addressConfirmed && viewmodel.orderType.isDelivery) {
                              navigatePayment = await showModalBottomSheet(context: context, builder: (context) => ModalAddressConfirm(userStore: userStore, menuViewmodel: viewmodel)) ?? false;
                            }
                            if (navigatePayment) {
                              if (context.mounted) {
                                showModalBottomSheet(context: context, builder: (context) => const ModalPayment());
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  PSize.i.sizedBoxH,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowEdit(BuildContext context, {required String label, required double value, bool isNegative = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: context.textTheme.bodyMedium?.muted(context)),
        Text(value > 0.01 ? "${isNegative ? "-" : ""}${value.toStringCurrency}" : " -- ", style: context.textTheme.bodyMedium?.copyWith(color: (isNegative && value > 0.1) ? context.color.errorColor : null)),
      ],
    );
  }
}
