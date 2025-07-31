import 'dart:convert';

import 'package:paipfood_package/paipfood_package.dart';

Map _addCreatedAt(Map<String, dynamic> data) {
  if (data['created_at'] == null) data.addAll({'created_at': DateTime.now().pToTimesTamptzFormat()});
  return data;
}

class UpdateQueusModel {
  final String establishmentId;
  final DateTime? createdAt;
  final DateTime updatedAt;
  final String table;
  final String operation;
  final Map data;
  UpdateQueusModel({
    required this.updatedAt,
    required this.establishmentId,
    required this.table,
    this.createdAt,
    this.operation = 'update',
    this.data = const {},
  });

  UpdateQueusModel copyWith({
    String? establishmentId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? table,
    String? operation,
    Map? data,
  }) {
    return UpdateQueusModel(
      establishmentId: establishmentId ?? this.establishmentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      table: table ?? this.table,
      operation: operation ?? this.operation,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'establishment_id': establishmentId,
      'updated_at': updatedAt.pToTimesTamptzFormat(),
      'table': table,
      'operation': operation,
      'data': data,
    };
  }

  factory UpdateQueusModel.fromMap(Map<String, dynamic> map) {
    return UpdateQueusModel(
      establishmentId: map['establishment_id'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      table: map['table'] ?? '',
      operation: map['operation'] ?? '',
      data: Map.from(map['data'] ?? const {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateQueusModel.fromJson(String source) => UpdateQueusModel.fromMap(json.decode(source));

  factory UpdateQueusModel.fromOrder({required OrderModel order}) {
    final data = order.toMap();
    if (order.charge != null) {
      data['charge'] = order.charge!.toMap();
    }
    return UpdateQueusModel(
      establishmentId: order.establishmentId,
      table: OrderModel.box,
      updatedAt: DateTime.now(),
      data: _addCreatedAt(data),
      operation: "upsert",
    );
  }
  factory UpdateQueusModel.fromOrders({required List<OrderModel> orders}) {
    final orderIds = orders.map((order) => order.id).toList();
    return UpdateQueusModel(
      establishmentId: orders.first.establishmentId,
      table: OrderModel.boxList,
      updatedAt: DateTime.now(),
      data: {"ids": orderIds},
      operation: "upsert",
    );
  }

  factory UpdateQueusModel.fromOrderReactivity({required OrderModel order, BillModel? bill}) {
    final data = order.toMap();
    if (bill != null) {
      data.addAll({
        'bill': bill.toMap(),
      });
    }

    return UpdateQueusModel(
      establishmentId: order.establishmentId,
      table: OrderModel.boxReactivity,
      updatedAt: DateTime.now(),
      data: _addCreatedAt(data),
      operation: "upsert",
    );
  }

  factory UpdateQueusModel.fromEstablishment(EstablishmentModel establishment) {
    return UpdateQueusModel(
      establishmentId: establishment.id,
      table: EstablishmentModel.box,
      updatedAt: DateTime.now(),
      data: _addCreatedAt(establishment.toMap()),
      operation: "upsert",
    );
  }
  factory UpdateQueusModel.fromBill(BillModel bill) {
    return UpdateQueusModel(
      establishmentId: bill.establishmentId,
      table: BillModel.box,
      updatedAt: DateTime.now(),
      data: _addCreatedAt(bill.toMap()),
      operation: "upsert",
    );
  }
  factory UpdateQueusModel.fromTable(TableModel table) {
    return UpdateQueusModel(
      establishmentId: table.establishmentId,
      table: TableModel.box,
      updatedAt: DateTime.now(),
      data: _addCreatedAt(table.toMap()),
      operation: "upsert",
    );
  }

  factory UpdateQueusModel.fromOrderCommand(OrderCommandModel orderCommand) {
    return UpdateQueusModel(
      establishmentId: orderCommand.establishmentId,
      table: OrderCommandModel.box,
      updatedAt: DateTime.now(),
      data: _addCreatedAt(orderCommand.toMap()),
      operation: "upsert",
    );
  }
}
