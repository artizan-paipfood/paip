import 'dart:convert';

import 'package:paipfood_package/paipfood_package.dart';

class OrderCommandModel {
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? customerId;
  final String observations;
  final TableStatus status;
  final String establishmentId;
  final int number;
  final bool isDeleted;
  final String? billId;
  OrderCommandModel(
      {required this.establishmentId,
      required this.number,
      this.createdAt,
      this.updatedAt,
      this.customerId,
      this.observations = '',
      this.status = TableStatus.available,
      this.isDeleted = false,
      this.billId});

  static const String box = 'order_commands';

  OrderCommandModel copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? customerId,
    String? observations,
    TableStatus? status,
    String? establishmentId,
    int? number,
    bool? isDeleted,
    String? billId,
  }) {
    return OrderCommandModel(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      customerId: customerId ?? this.customerId,
      observations: observations ?? this.observations,
      status: status ?? this.status,
      establishmentId: establishmentId ?? this.establishmentId,
      number: number ?? this.number,
      isDeleted: isDeleted ?? this.isDeleted,
      billId: billId ?? this.billId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'updated_at': DateTime.now().pToTimesTamptzFormat(),
      'customer_id': customerId,
      'observations': observations,
      'status': status.name,
      'establishment_id': establishmentId,
      'number': number,
      'is_deleted': isDeleted,
      'bill_id': billId
    };
  }

  factory OrderCommandModel.fromMap(Map map) {
    return OrderCommandModel(
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      customerId: map['customer_id'],
      observations: map['observations'] ?? '',
      status: TableStatus.fromMap(map['status']),
      establishmentId: map['establishment_id'],
      number: map['number'].toInt(),
      isDeleted: map['is_deleted'] ?? false,
      billId: map['bill_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderCommandModel.fromJson(String source) => OrderCommandModel.fromMap(json.decode(source));
}
