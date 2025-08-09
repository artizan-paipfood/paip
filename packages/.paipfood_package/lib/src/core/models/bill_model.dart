import 'dart:convert';

import 'package:paipfood_package/paipfood_package.dart';

class BillModel {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String establishmentId;
  final String? customerId;
  final int? tableNumber;
  final int? orderCommandNumber;
  final List<PaymentDto> payments;
  final double? discount;
  final double? serviceTax;

  BillModel({
    required this.id,
    required this.establishmentId,
    this.createdAt,
    this.updatedAt,
    this.customerId,
    this.tableNumber,
    this.orderCommandNumber,
    this.payments = const [],
    this.discount,
    this.serviceTax,
  });

  static const String box = 'bills';

  BillModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? establishmentId,
    String? customerId,
    int? tableNumber,
    int? orderCommandNumber,
    List<PaymentDto>? payments,
    double? discount,
    double? serviceTax,
  }) {
    return BillModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      establishmentId: establishmentId ?? this.establishmentId,
      customerId: customerId ?? this.customerId,
      tableNumber: tableNumber ?? this.tableNumber,
      orderCommandNumber: orderCommandNumber ?? this.orderCommandNumber,
      payments: payments ?? this.payments,
      discount: discount ?? this.discount,
      serviceTax: serviceTax ?? this.serviceTax,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'updated_at': updatedAt?.pToTimesTamptzFormat() ?? DateTime.now().pToTimesTamptzFormat(),
      'establishment_id': establishmentId,
      'customer_id': customerId,
      'table_number': tableNumber,
      'order_command_number': orderCommandNumber,
      'payments': payments.map((e) => e.toMap()).toList(),
      'discount': discount,
      'service_tax': serviceTax
    };
  }

  factory BillModel.fromMap(Map map) {
    return BillModel(
      id: map['id'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      establishmentId: map['establishment_id'] ?? '',
      customerId: map['customer_id'],
      tableNumber: map['table_number']?.toInt(),
      orderCommandNumber: map['order_command_number']?.toInt(),
      payments: map['payments'] != null ? List<PaymentDto>.from(map['payments'].map((x) => PaymentDto.fromMap(x))) : [],
      discount: map['discount']?.toDouble(),
      serviceTax: map['service_tax']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory BillModel.fromJson(String source) => BillModel.fromMap(json.decode(source));
}
