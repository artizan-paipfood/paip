import 'dart:convert';

class TransferRefundResponse {
  final String id;
  final int amount;
  final String transfer;
  TransferRefundResponse({
    required this.id,
    required this.amount,
    required this.transfer,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'transfer': transfer,
    };
  }

  factory TransferRefundResponse.fromMap(Map<String, dynamic> map) {
    return TransferRefundResponse(
      id: map['id'],
      amount: map['amount']!.toInt(),
      transfer: map['transfer'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TransferRefundResponse.fromJson(String source) => TransferRefundResponse.fromMap(json.decode(source));
}
