import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';

enum TableStatus {
  ///A mesa está livre e pronta para uso.
  available(color: Colors.lightGreen),

  ///A mesa está atualmente ocupada por clientes.
  occupied(color: Colors.red),

  ///A mesa foi reservada para um horário específico e não está disponível para novos clientes.
  reserved(color: Colors.amber);

  // ///Os clientes terminaram o pedido, mas o pagamento ainda não foi concluído.
  // closingAccount(color: Colors.blue),

  // ///A mesa está sendo limpa/preparada para o próximo uso.
  // cleaning(color: Colors.cyan),

  // ///A mesa está fora de uso devido a problemas (e.g., quebrada, manutenção).
  // inMaintenance(color: Colors.red);

  final Color color;

  const TableStatus({required this.color});

  static TableStatus fromMap(String value) => TableStatus.values.firstWhere((element) => element.name == value, orElse: () => TableStatus.available);
}

class TableModel {
  final DateTime? createdAt;
  final DateTime? updatedAt;
  int? tableParentNumber;
  final TableStatus status;
  final String establishmentId;
  final String observations;
  final DateTime? bookingDate;
  final String? customerId;
  final int number;
  final String? tableAreaId;
  final int? index;
  final int capacity;
  final bool isDeleted;
  String? billId;
  final int? orderCommandNumber;
  TableModel({
    required this.number,
    required this.establishmentId,
    this.createdAt,
    this.updatedAt,
    this.tableParentNumber,
    this.observations = '',
    this.bookingDate,
    this.customerId,
    this.status = TableStatus.available,
    this.tableAreaId,
    this.index,
    this.capacity = 0,
    this.isDeleted = false,
    this.billId,
    this.orderCommandNumber,
  });

  static const String box = 'tables';
  TableModel copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    int? tableParentNumber,
    TableStatus? status,
    String? establishmentId,
    String? observations,
    DateTime? bookingDate,
    String? customerId,
    int? number,
    String? tableAreaId,
    int? index,
    int? capacity,
    bool? isDeleted,
    String? billId,
    int? orderCommandNumber,
  }) {
    return TableModel(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: DateTime.now(),
      tableParentNumber: tableParentNumber ?? this.tableParentNumber,
      status: status ?? this.status,
      establishmentId: establishmentId ?? this.establishmentId,
      observations: observations ?? this.observations,
      bookingDate: bookingDate ?? this.bookingDate,
      customerId: customerId ?? this.customerId,
      number: number ?? this.number,
      tableAreaId: tableAreaId ?? this.tableAreaId,
      index: index ?? this.index,
      capacity: capacity ?? this.capacity,
      isDeleted: isDeleted ?? this.isDeleted,
      billId: billId ?? this.billId,
      orderCommandNumber: orderCommandNumber ?? this.orderCommandNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'updated_at': DateTime.now().pToTimesTamptzFormat(),
      'table_parent_number': tableParentNumber,
      'establishment_id': establishmentId,
      'observations': observations,
      'booking_date': bookingDate?.millisecondsSinceEpoch,
      'customer_id': customerId,
      'number': number,
      'status': status.name,
      'table_area_id': tableAreaId,
      'index': index,
      'capacity': capacity,
      'is_deleted': isDeleted,
      'bill_id': billId,
      'order_command_number': orderCommandNumber
    };
  }

  factory TableModel.fromMap(Map map) {
    return TableModel(
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      tableParentNumber: map['table_parent_number'],
      establishmentId: map['establishment_id'],
      observations: map['observations'] ?? '',
      bookingDate: map['booking_date'] != null ? DateTime.parse(map['booking_date']) : null,
      customerId: map['customer_id'],
      number: map['number'].toInt(),
      status: TableStatus.fromMap(map['status']),
      tableAreaId: map['table_area_id'],
      index: map['index'],
      capacity: map['capacity'].toInt(),
      isDeleted: map['is_deleted'] ?? false,
      billId: map['bill_id'],
      orderCommandNumber: map['order_command_number'],
    );
  }

  int buildTableNumber() => tableParentNumber != null ? tableParentNumber! : number;

  String toJson() => json.encode(toMap());

  bool get isPendingOpen => switch (status) {
        TableStatus.occupied => false,
        _ => true,
      };

  factory TableModel.fromJson(String source) => TableModel.fromMap(json.decode(source));
}
