import 'dart:convert';

class RetrieveSessionResponse {
  final String status;
  final String? paymentIntent;
  RetrieveSessionResponse({
    required this.status,
    required this.paymentIntent,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'payment_intent': paymentIntent,
    };
  }

  factory RetrieveSessionResponse.fromMap(Map<String, dynamic> map) {
    return RetrieveSessionResponse(
      status: map['status'] ?? '',
      paymentIntent: map['payment_intent'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RetrieveSessionResponse.fromJson(String source) => RetrieveSessionResponse.fromMap(json.decode(source));
}
