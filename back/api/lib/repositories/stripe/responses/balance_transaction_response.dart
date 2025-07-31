import 'dart:convert';

class BalanceTransactionResponse {
  final int amount;
  final String currency;
  final int fee;

  /// [net] is amount - fee
  final int net;

  BalanceTransactionResponse({required this.amount, required this.currency, required this.fee, required this.net});

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'currency': currency,
      'fee': fee,
      'net': net,
    };
  }

  factory BalanceTransactionResponse.fromMap(Map<String, dynamic> map) {
    return BalanceTransactionResponse(
      amount: map['amount']?.toInt() ?? 0,
      currency: map['currency'] ?? '',
      fee: map['fee']?.toInt() ?? 0,
      net: map['net']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BalanceTransactionResponse.fromJson(String source) => BalanceTransactionResponse.fromMap(json.decode(source));
}
