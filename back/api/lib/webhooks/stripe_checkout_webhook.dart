import 'package:core/core.dart';

enum StripePaymentStatus {
  paid,
  unpaid,
  undefined;

  static StripePaymentStatus fromMap(String value) => StripePaymentStatus.values.firstWhere((e) => e.name == value, orElse: () => StripePaymentStatus.undefined);
}

enum StripeCheckoutStatus {
  complete,
  expired,
  undefined;

  static StripeCheckoutStatus fromMap(String value) => StripeCheckoutStatus.values.firstWhere((e) => e.name == value, orElse: () => StripeCheckoutStatus.undefined);
}

extension StripeDbLocaleExtension on DbLocale {
  DbLocale getByCurrency(String currency) {
    return switch (currency.toUpperCase()) {
      'GPB' => DbLocale.gb,
      'BRL' => DbLocale.br,
      _ => DbLocale.br,
    };
  }
}

class StripeCheckoutWebhook {
  final String sessionId;
  final String mode;
  final StripeCheckoutStatus status;
  final StripePaymentStatus paymentStatus;
  final int amountTotal;
  final String currency;
  final String? paymentIntent;

  final String clientReferenceId;
  StripeCheckoutWebhook({required this.sessionId, required this.mode, required this.status, required this.paymentStatus, required this.amountTotal, required this.currency, required this.clientReferenceId, this.paymentIntent});

  factory StripeCheckoutWebhook.fromMap(Map<String, dynamic> map) {
    final data = map['data']['object'] as Map<String, dynamic>;
    return StripeCheckoutWebhook(
      sessionId: data['id'] ?? '',
      mode: data['mode'] ?? '',
      status: data['status'] != null ? StripeCheckoutStatus.fromMap(data['status']) : StripeCheckoutStatus.undefined,
      paymentStatus: data['payment_status'] != null ? StripePaymentStatus.fromMap(data['payment_status']) : StripePaymentStatus.undefined,
      amountTotal: data['amount_total']!.toInt(),
      currency: data['currency'],
      paymentIntent: data['payment_intent'],
      clientReferenceId: data['client_reference_id'],
    );
  }

  DbLocale get locale => DbLocale.br.getByCurrency(currency);
}
