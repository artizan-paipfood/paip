import 'dart:convert';
import 'package:core/core.dart';

class ChargeEntity {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? establishmentId;
  final String? orderId;
  final double amount;
  final ChargeStatus status;
  final PaymentProvider paymentProvider;
  final String paymentId;
  final Map<String, dynamic> metadata;
  final double? netAmount;
  final double? driverFee;
  final DbLocale locale;
  ChargeEntity({
    required this.id,
    required this.locale,
    required this.amount,
    required this.status,
    required this.paymentProvider,
    required this.paymentId,
    required this.metadata,
    this.createdAt,
    this.orderId,
    this.updatedAt,
    this.establishmentId,
    this.netAmount,
    this.driverFee,
  });
  static const String table = 'charges';
  ChargeEntity copyWith({
    String? id,
    String? establishmentId,
    String? orderId,
    double? amount,
    ChargeStatus? status,
    PaymentProvider? paymentProvider,
    String? paymentId,
    Map<String, dynamic>? metadata,
    double? netAmount,
    double? driverFee,
    DbLocale? locale,
  }) {
    return ChargeEntity(
      id: id ?? this.id,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      establishmentId: establishmentId ?? this.establishmentId,
      orderId: orderId ?? this.orderId,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      paymentProvider: paymentProvider ?? this.paymentProvider,
      paymentId: paymentId ?? this.paymentId,
      metadata: metadata ?? this.metadata,
      netAmount: netAmount ?? this.netAmount,
      driverFee: driverFee ?? this.driverFee,
      locale: locale ?? this.locale,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'updated_at': updatedAt?.toPaipDB() ?? DateTime.now().toPaipDB(),
      'establishment_id': establishmentId,
      'order_id': orderId,
      'amount': amount,
      'status': status.name,
      'payment_provider': paymentProvider.name,
      'payment_id': paymentId,
      'metadata': metadata,
      'net_amount': netAmount,
      'driver_fee': driverFee,
      'locale': locale.name,
    };
  }

  factory ChargeEntity.fromMap(
    Map<String, dynamic> map,
  ) {
    return ChargeEntity(
      id: map['id'] ?? '',
      createdAt: map['created_at'] != null
          ? DateTime.parse(
              map['created_at'],
            ).toLocal()
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(
              map['updated_at'],
            ).toLocal()
          : null,
      establishmentId: map['establishment_id'],
      orderId: map['order_id'],
      amount: map['amount']?.toDouble() ?? 0.0,
      status: ChargeStatus.fromMap(
        map['status'],
      ),
      paymentProvider: PaymentProvider.fromMap(
        map['payment_provider'],
      ),
      paymentId: map['payment_id'] ?? '',
      metadata: Map<String, dynamic>.from(
        map['metadata'],
      ),
      netAmount: map['net_amount']?.toDouble(),
      driverFee: map['driver_fee']?.toDouble(),
      locale: DbLocale.fromMap(
        map['locale'],
      ),
    );
  }

  String toJson() => json.encode(
        toMap(),
      );

  factory ChargeEntity.fromJson(
    String source,
  ) =>
      ChargeEntity.fromMap(
        json.decode(
          source,
        ),
      );
}
