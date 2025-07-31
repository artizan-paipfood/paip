import 'dart:convert';

class TransferResponse {
  final String id;
  final int amount;
  final String destination;
  final String balanceTransaction;
  final String currency;
  TransferResponse({
    required this.id,
    required this.amount,
    required this.destination,
    required this.balanceTransaction,
    required this.currency,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'destination': destination,
      'balance_transaction': balanceTransaction,
      'currency': currency,
    };
  }

  factory TransferResponse.fromMap(Map<String, dynamic> map) {
    return TransferResponse(
      id: map['id'],
      amount: map['amount']?.toInt(),
      destination: map['destination'],
      balanceTransaction: map['balance_transaction'],
      currency: map['currency'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransferResponse.fromJson(String source) => TransferResponse.fromMap(json.decode(source));
}
