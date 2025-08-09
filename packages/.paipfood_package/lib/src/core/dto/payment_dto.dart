import 'dart:convert';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PaymentDto {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? orderId;
  final double value;
  final PaymentType paymentType;
  final String establishmentId;
  final String? billId;
  final String? observation;
  PaymentDto({
    required this.id,
    required this.establishmentId,
    this.createdAt,
    this.updatedAt,
    this.orderId,
    this.value = 0.0,
    this.paymentType = PaymentType.cash,
    this.billId,
    this.observation,
  });
  static String box = 'payments';

  PaymentDto copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? orderId,
    double? value,
    String? description,
    PaymentType? paymentType,
    String? establishmentId,
    String? billId,
    String? observation,
  }) {
    return PaymentDto(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      orderId: orderId ?? this.orderId,
      value: value ?? this.value,
      paymentType: paymentType ?? this.paymentType,
      establishmentId: establishmentId ?? this.establishmentId,
      billId: billId ?? this.billId,
      observation: observation ?? this.observation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt?.pToTimesTamptzFormat() ?? DateTime.now().pToTimesTamptzFormat(),
      'updated_at': updatedAt?.pToTimesTamptzFormat() ?? DateTime.now().pToTimesTamptzFormat(),
      'order_id': orderId,
      'value': value,
      'payment_type': paymentType.name,
      'establishment_id': establishmentId,
      'bill_id': billId,
      'observation': observation
    };
  }

  factory PaymentDto.fromMap(Map<String, dynamic> map) {
    return PaymentDto(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      orderId: map['order_id'],
      value: map['value']?.toDouble() ?? 0.0,
      paymentType: PaymentType.fromMap(map['payment_type']),
      establishmentId: map['establishment_id'],
      billId: map['bill_id'],
      observation: map['observation'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentDto.fromJson(String source) => PaymentDto.fromMap(json.decode(source));
}
