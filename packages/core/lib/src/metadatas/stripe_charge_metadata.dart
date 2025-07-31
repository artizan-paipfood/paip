import 'dart:convert';

class StripeChargeMetadata {
  final String sessionId;
  final String sessionUrl;
  final String? paymentIntent;
  final String? chargeId;
  final String? balanceTransactionId;
  final List<StripeTransferRefound> transfersRefunds;
  final int? stripeFee;
  final int? net;

  StripeChargeMetadata({
    required this.sessionId,
    required this.sessionUrl,
    this.paymentIntent,
    this.chargeId,
    this.balanceTransactionId,
    this.transfersRefunds = const [],
    this.stripeFee,
    this.net,
  });

  Map<String, dynamic> toMap() {
    return {
      'session_id': sessionId,
      'session_url': sessionUrl,
      'payment_intent': paymentIntent,
      'charge_id': chargeId,
      'balance_transaction_id': balanceTransactionId,
      'transfers_refunds': transfersRefunds.map((x) => x.toMap()).toList(),
      'stripe_fee': stripeFee,
      'net': net,
    };
  }

  factory StripeChargeMetadata.fromMap(Map<String, dynamic> map) {
    return StripeChargeMetadata(
      sessionId: map['session_id'] ?? '',
      sessionUrl: map['session_url'] ?? '',
      paymentIntent: map['payment_intent'] ?? '',
      chargeId: map['charge_id'] ?? '',
      balanceTransactionId: map['balance_transaction_id'] ?? '',
      transfersRefunds: List<StripeTransferRefound>.from(map['transfers_refunds']?.map((x) => StripeTransferRefound.fromMap(x))),
      stripeFee: map['stripe_fee']?.toInt() ?? 0,
      net: map['net']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory StripeChargeMetadata.fromJson(String source) => StripeChargeMetadata.fromMap(json.decode(source));

  StripeChargeMetadata copyWith({
    String? sessionId,
    String? sessionUrl,
    String? paymentIntent,
    String? chargeId,
    String? balanceTransactionId,
    List<StripeTransferRefound>? transfersRefunds,
    int? stripeFee,
    int? net,
  }) {
    return StripeChargeMetadata(
      sessionId: sessionId ?? this.sessionId,
      sessionUrl: sessionUrl ?? this.sessionUrl,
      paymentIntent: paymentIntent ?? this.paymentIntent,
      chargeId: chargeId ?? this.chargeId,
      balanceTransactionId: balanceTransactionId ?? this.balanceTransactionId,
      transfersRefunds: transfersRefunds ?? this.transfersRefunds,
      stripeFee: stripeFee ?? this.stripeFee,
      net: net ?? this.net,
    );
  }
}

class StripeTransferRefound {
  final String accountId;
  final int amount;
  final String transferId;
  final String description;
  StripeTransferRefound({
    required this.accountId,
    required this.amount,
    required this.transferId,
    this.description = '-',
  });

  StripeTransferRefound copyWith({
    String? accountId,
    int? amount,
    String? transferId,
    String? description,
  }) {
    return StripeTransferRefound(
      accountId: accountId ?? this.accountId,
      amount: amount ?? this.amount,
      transferId: transferId ?? this.transferId,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accountId': accountId,
      'amount': amount,
      'transferId': transferId,
      'description': description,
    };
  }

  factory StripeTransferRefound.fromMap(Map<String, dynamic> map) {
    return StripeTransferRefound(
      accountId: map['accountId'] ?? '',
      amount: map['amount']?.toInt() ?? 0,
      transferId: map['transferId'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StripeTransferRefound.fromJson(String source) => StripeTransferRefound.fromMap(json.decode(source));
}
