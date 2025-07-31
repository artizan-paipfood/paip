import 'dart:convert';

import 'package:core/core.dart';

class PaymentStatusResponse {
  final String id;
  final double amount;
  final PaymentStatus status;
  final PaymentProvider provider;
  final Map<String, dynamic>? metadata;
  PaymentStatusResponse({
    required this.id,
    required this.amount,
    required this.status,
    required this.provider,
    this.metadata,
  });

  PaymentStatusResponse copyWith({
    String? id,
    double? amount,
    PaymentStatus? status,
    PaymentProvider? provider,
    Map<String, dynamic>? metadata,
  }) {
    return PaymentStatusResponse(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      provider: provider ?? this.provider,
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'status': status.name,
      'provider': provider.name,
      'metadata': metadata,
    };
  }

  factory PaymentStatusResponse.fromMap(
    Map<String, dynamic> map,
  ) {
    return PaymentStatusResponse(
      id: map['id'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
      status: PaymentStatus.fromMap(
        map['status'],
      ),
      provider: PaymentProvider.fromMap(
        map['provider'],
      ),
      metadata: map['metadata'] != null
          ? Map<String, dynamic>.from(
              map['metadata'],
            )
          : null,
    );
  }

  String toJson() => json.encode(
        toMap(),
      );

  factory PaymentStatusResponse.fromJson(
    String source,
  ) =>
      PaymentStatusResponse.fromMap(
        json.decode(
          source,
        ),
      );
}
