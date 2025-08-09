import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/config/sub_modules/payments/domain/usecases/payment_provider_stripe_usecase.dart';
import 'package:manager/src/modules/config/sub_modules/payments/domain/usecases/payment_provider_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class StripeCardComponentViewmodel extends ChangeNotifier {
  final PaymentProviderUsecase paymentProviderUsecase;
  final PaymentProviderStripeUsecase paymentProviderStripeUsecase;

  StripeCardComponentViewmodel({required this.paymentProviderUsecase, required this.paymentProviderStripeUsecase});
  PaymentProviderView? _paymentProvider;
  PaymentProviderView? get paymentProvider => _paymentProvider;

  Future<Status> load() async {
    _paymentProvider = await paymentProviderUsecase.loadPaymentProvider(paymentProviderId: establishmentProvider.value.paymentProviderId!);
    if (_paymentProvider?.stripe != null) {
      final stripe = await paymentProviderStripeUsecase.verifyStatus(stripe: _paymentProvider!.stripe!);
      _paymentProvider = _paymentProvider?.copyWith(stripe: stripe);
    }

    return Status.complete;
  }

  void toggleStatusStripe(PaymentProviderAccountStatus status) {
    _paymentProvider = _paymentProvider?.copyWith(stripe: _paymentProvider!.stripe!.copyWith(status: status));
    notifyListeners();
  }

  Future<String> createAccount() async {
    final result = await paymentProviderStripeUsecase.createAccount(paymentProviderId: establishmentProvider.value.paymentProviderId!);
    _paymentProvider = _paymentProvider?.copyWith(stripe: result.stripe);
    notifyListeners();
    return result.url;
  }

  Future<String> resolvePendencies() async {
    final result = await paymentProviderStripeUsecase.getLinkAccount(accountId: _paymentProvider!.stripe!.accountId);
    return result;
  }
}
