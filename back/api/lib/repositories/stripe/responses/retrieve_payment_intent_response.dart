import 'dart:convert';

class RetrievePaymentIntentResponse {
  final String status;
  final String latestCharge;
  final int amount;
  RetrievePaymentIntentResponse({
    required this.status,
    required this.latestCharge,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'latest_charge': latestCharge,
      'amount': amount,
    };
  }

  factory RetrievePaymentIntentResponse.fromMap(Map<String, dynamic> map) {
    return RetrievePaymentIntentResponse(
      status: map['status'] ?? '',
      latestCharge: map['latest_charge'] ?? '',
      amount: map['amount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RetrievePaymentIntentResponse.fromJson(String source) => RetrievePaymentIntentResponse.fromMap(json.decode(source));
}
