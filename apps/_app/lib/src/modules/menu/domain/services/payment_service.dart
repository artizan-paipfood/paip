import 'package:app/l10n/l18n_extension.dart';

import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/user/presenters/viewmodels/user_store.dart';
import 'package:core/core.dart';
import "package:universal_html/html.dart" as html;
import 'package:flutter/material.dart';
import 'package:app/src/core/data/data_source.dart';
import 'package:app/src/modules/menu/presenters/view_models/menu_viewmodel.dart';
import 'package:app/src/modules/menu/presenters/components/modal_change_to_cash.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PaymentService {
  final MenuViewmodel menuViewmodel;
  final UserStore userStore;
  final StripeApi stripeApi;
  final IChargesRepository chargesApi;

  PaymentService({required this.menuViewmodel, required this.userStore, required this.stripeApi, required this.chargesApi});
  final dataSource = DataSource.instance;

  bool get stripe => dataSource.paymentMethod.stripe != null && dataSource.paymentMethod.stripe!.status == PaymentProviderAccountStatus.enable;

  CardInformationModel cardInformationModel = CardInformationModel(email: '', number: '', name: '', date: '', cvv: '');
  PaymentType _paymentType = PaymentType.cash;
  PaymentType get paymentType => _paymentType;
  List<PaymentType> get paymentTypes => menuViewmodel.establishment.paymentMethod?.getPaymentTypesByOrderType(menuViewmodel.orderType) ?? [];

  OrderModel get order => menuViewmodel.orderViewmodel.order;

  Future<void> onPay(BuildContext context, {required PaymentType paymentType}) async {
    _paymentType = paymentType;

    switch (paymentType) {
      case PaymentType.credit:
        return await _onCredit(context);
      case PaymentType.debit:
        return await _onDebit(context);
      case PaymentType.pix:
        return await _onQrCode(context);
      default:
        return await _onCash(context);
    }
  }

  Future<void> _onCredit(BuildContext context) async {
    menuViewmodel.orderViewmodel.setOrder(order.copyWith(paymentType: PaymentType.credit));
    if (stripe) {
      Loader.show(context);
      menuViewmodel.orderViewmodel.setOrder(order.copyWith(paymentProvider: PaymentProvider.stripe));
      OrderModel orderResult = await _saveOrder();
      final String chargeId = uuid;
      if (context.mounted) {
        final stripeSession = await stripeApi.checkoutCreateSession(
          chargeId: chargeId,
          locale: menuViewmodel.establishment.locale,
          amount: menuViewmodel.getTotal,
          cancelUrl: order.cancelUrlApp(),
          successUrl: order.sucessUrlApp(),
          description: '${context.i18n.pedido} - ${menuViewmodel.establishment.fantasyName}',
        );
        orderResult = orderResult.copyWith(
          charge: ChargeEntity(
            id: chargeId,
            amount: order.getAmount,
            orderId: orderResult.id,
            status: ChargeStatus.pending,
            paymentProvider: PaymentProvider.stripe,
            locale: menuViewmodel.establishment.locale,
            paymentId: stripeSession.id,
            metadata: StripeChargeMetadata(sessionId: stripeSession.id, sessionUrl: stripeSession.url).toMap(),
          ),
        );
        await chargesApi.upsert(charges: [orderResult.charge!]);
        menuViewmodel.orderViewmodel.setOrder(order.copyWith(chargeId: orderResult.charge!.id));
        await _saveOrder();
        if (context.mounted) Go.of(context).goNeglect(order.cancelUrlApp());
        Future.delayed(100.milliseconds, () {
          html.window.location.href = stripeSession.url;
        });
      }
      return;
    }
    await _saveOrder();
    if (context.mounted) _goOrderPage(context);
  }

  Future<void> _onCash(BuildContext context) async {
    await showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) => ModalChangeToCash(store: menuViewmodel));
    if (context.mounted) Loader.show(context);
    await _saveOrder();
    Loader.hide();
    if (context.mounted) _goOrderPage(context);
  }

  Future<void> _onDebit(BuildContext context) async {
    Loader.show(context);
    await _saveOrder();
    Loader.hide();
    if (context.mounted) _goOrderPage(context);
  }

  Future<void> _onQrCode(BuildContext context) async {
    Loader.show(context);
    await _saveOrder();
    Loader.hide();

    if (context.mounted) _goOrderPage(context);
  }

  Future<OrderModel> _saveOrder() async {
    return await menuViewmodel.saveOrder(paymentType: paymentType);
  }

  _goOrderPage(BuildContext context) {
    Future.delayed(500.microseconds, () {
      if (context.mounted) {
        Go.of(context).goNeglect(Routes.order(orderId: menuViewmodel.orderViewmodel.order.id));
      }
    });
  }
}
