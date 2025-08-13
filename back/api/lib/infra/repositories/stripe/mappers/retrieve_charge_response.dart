import 'dart:convert';

class RetrieveChargeResponse {
  final String balanceTransaction;
  final String paymentIntent;
  final bool refunded;
  final String status;

  RetrieveChargeResponse({required this.balanceTransaction, required this.paymentIntent, required this.refunded, required this.status});

  Map<String, dynamic> toMap() {
    return {
      'balanceTransaction': balanceTransaction,
      'paymentIntent': paymentIntent,
      'refunded': refunded,
      'status': status,
    };
  }

  factory RetrieveChargeResponse.fromMap(Map<String, dynamic> map) {
    return RetrieveChargeResponse(
      balanceTransaction: map['balance_transaction'] ?? '',
      paymentIntent: map['payment_intent'] ?? '',
      refunded: map['refunded'] ?? false,
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RetrieveChargeResponse.fromJson(String source) => RetrieveChargeResponse.fromMap(json.decode(source));
}
