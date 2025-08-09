import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PaymentMethodByEstablishmentView {
  final PaymentMethodModel? paymentMethod;
  final PaymentProviderStripeEntity? stripe;
  PaymentMethodByEstablishmentView({
    this.paymentMethod,
    this.stripe,
  });

  factory PaymentMethodByEstablishmentView.fromMap(Map<String, dynamic> map) {
    return PaymentMethodByEstablishmentView(
      paymentMethod: PaymentMethodModel.fromMap(map),
      stripe: map['payment_provider_stripe'] != null ? PaymentProviderStripeEntity.fromMap(map['payment_provider_stripe']) : null,
    );
  }
}
