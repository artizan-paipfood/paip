import 'package:core/core.dart';

class CreateAccountStripeDto {
  final PaymentProviderStripeEntity stripe;
  final String url;
  CreateAccountStripeDto({
    required this.stripe,
    required this.url,
  });

  CreateAccountStripeDto copyWith({
    PaymentProviderStripeEntity? stripe,
    String? url,
  }) {
    return CreateAccountStripeDto(
      stripe: stripe ?? this.stripe,
      url: url ?? this.url,
    );
  }
}
