import 'dart:convert';

import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class OrdersView {
  final OrderModel order;
  final ChargeEntity? charge;
  final BillModel? bill;
  OrdersView({
    required this.order,
    this.charge,
    this.bill,
  });

  OrdersView copyWith({
    OrderModel? order,
    ChargeEntity? charge,
    BillModel? bill,
  }) {
    return OrdersView(
      order: order ?? this.order,
      charge: charge ?? this.charge,
      bill: bill ?? this.bill,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'order': order.toMap(),
      'charge': charge?.toMap(),
      'bill': bill?.toMap(),
    };
  }

  factory OrdersView.fromMap(Map<String, dynamic> map) {
    return OrdersView(
      order: OrderModel.fromMap(map['order']),
      charge: map['charge'] != null ? ChargeEntity.fromMap(map['charge']) : null,
      bill: map['bill'] != null ? BillModel.fromMap(map['bill']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdersView.fromJson(String source) => OrdersView.fromMap(json.decode(source));
}
