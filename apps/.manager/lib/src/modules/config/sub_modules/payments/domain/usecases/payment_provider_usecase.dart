import 'package:core/core.dart';

class PaymentProviderUsecase {
  final PaymentProviderApi paymentProviderApi;
  final ViewsApi viewsApi;
  final StripeApi stripeApi;
  final PaymentProviderStripeApi paymentProviderStripeApi;
  PaymentProviderUsecase({
    required this.paymentProviderApi,
    required this.viewsApi,
    required this.stripeApi,
    required this.paymentProviderStripeApi,
  });

  Future<PaymentProviderEntity> createPaymentProvider(PaymentProviderEntity paymentProvider) async {
    return await paymentProviderApi.create(paymentProvider);
  }

  Future<PaymentProviderView?> loadPaymentProvider({required String paymentProviderId}) async {
    return await viewsApi.getPaymentProviderView(id: paymentProviderId);
  }
}
