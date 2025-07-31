import 'dart:convert';

import 'package:core/core.dart';

class PaymentProviderStripeEntity {
  final String paymentProviderId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String accountId;
  final double? fixedFee;
  final PaymentProviderAccountStatus status;
  PaymentProviderStripeEntity({
    required this.paymentProviderId,
    this.createdAt,
    this.updatedAt,
    required this.accountId,
    this.fixedFee,
    this.status = PaymentProviderAccountStatus.pending,
  });
  static const String table = 'payment_provider_stripe';

  PaymentProviderStripeEntity copyWith({
    String? paymentProviderId,
    String? accountId,
    double? fixedFee,
    PaymentProviderAccountStatus? status,
  }) {
    return PaymentProviderStripeEntity(
      paymentProviderId: paymentProviderId ?? this.paymentProviderId,
      updatedAt: DateTime.now(),
      accountId: accountId ?? this.accountId,
      fixedFee: fixedFee ?? this.fixedFee,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'payment_provider_id': paymentProviderId,
      'updated_at': updatedAt?.toPaipDB() ?? DateTime.now().toPaipDB(),
      'account_id': accountId,
      'fixed_fee': fixedFee,
      'status': status.name,
    };
  }

  factory PaymentProviderStripeEntity.fromMap(
    Map<String, dynamic> map,
  ) {
    return PaymentProviderStripeEntity(
      paymentProviderId: map['payment_provider_id'],
      createdAt: map['created_at'] != null
          ? DateTime.parse(
              map['created_at'],
            )
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(
              map['updated_at'],
            )
          : null,
      accountId: map['account_id'],
      fixedFee: map['fixed_fee']?.toDouble(),
      status: PaymentProviderAccountStatus.fromMap(
        map['status'],
      ),
    );
  }

  String toJson() => json.encode(
        toMap(),
      );

  factory PaymentProviderStripeEntity.fromJson(
    String source,
  ) =>
      PaymentProviderStripeEntity.fromMap(
        json.decode(
          source,
        ),
      );
}
