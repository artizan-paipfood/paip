import 'dart:convert';

class RefundResponse {
  final String id;
  final int amount;
  final String balanceTransaction;
  final String charge;

  RefundResponse({required this.id, required this.amount, required this.balanceTransaction, required this.charge});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'balance_transaction': balanceTransaction,
      'charge': charge,
    };
  }

  factory RefundResponse.fromMap(Map<String, dynamic> map) {
    return RefundResponse(
      id: map['id'] ?? '',
      amount: map['amount']?.toInt() ?? 0,
      balanceTransaction: map['balance_transaction'] ?? '',
      charge: map['charge'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RefundResponse.fromJson(String source) => RefundResponse.fromMap(json.decode(source));
}
