import 'dart:convert';

import 'package:core/core.dart';

class OrderItemsEntity {
  final String id;
  final String description;
  final int index;
  final double qty;
  final UnityMeasure unityMeasure;
  final String? sizeId;
  final String productId;
  final String? observation;
  final double amount;
  final List<ComplementItensMetadata> complementItens;
  final int? qtyFlavorPizza;
  OrderItemsEntity({
    required this.id,
    required this.description,
    required this.index,
    required this.qty,
    required this.unityMeasure,
    required this.productId,
    required this.amount,
    required this.complementItens,
    this.sizeId,
    this.observation,
    this.qtyFlavorPizza,
  });

  OrderItemsEntity copyWith({
    String? id,
    String? description,
    int? index,
    double? qty,
    UnityMeasure? unityMeasure,
    String? sizeId,
    String? productId,
    String? observation,
    double? amount,
    List<ComplementItensMetadata>? complementItens,
    int? qtyFlavorPizza,
  }) {
    return OrderItemsEntity(
      id: id ?? this.id,
      description: description ?? this.description,
      index: index ?? this.index,
      qty: qty ?? this.qty,
      unityMeasure: unityMeasure ?? this.unityMeasure,
      sizeId: sizeId ?? this.sizeId,
      productId: productId ?? this.productId,
      observation: observation ?? this.observation,
      amount: amount ?? this.amount,
      complementItens: complementItens ?? this.complementItens,
      qtyFlavorPizza: qtyFlavorPizza ?? this.qtyFlavorPizza,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'index': index,
      'qty': qty,
      'unity_measure': unityMeasure.name,
      'size_id': sizeId,
      'product_id': productId,
      'observation': observation,
      'amount': amount,
      'complement_itens': complementItens
          .map(
            (
              x,
            ) =>
                x.toMap(),
          )
          .toList(),
    };
  }

  factory OrderItemsEntity.fromMap(
    Map<String, dynamic> map,
  ) {
    return OrderItemsEntity(
      id: map['id'] ?? '',
      description: map['description'] ?? '',
      index: map['index']?.toInt() ?? 0,
      qty: map['qty']?.toDouble() ?? 0.0,
      unityMeasure: UnityMeasure.fromMap(
        map['unity_measure'],
      ),
      sizeId: map['size_id'],
      productId: map['product_id'] ?? '',
      observation: map['observation'],
      amount: map['amount']?.toDouble() ?? 0.0,
      complementItens: List<ComplementItensMetadata>.from(
        map['complement_itens']?.map(
          (
            x,
          ) =>
              ComplementItensMetadata.fromMap(
            x,
          ),
        ),
      ),
    );
  }

  String toJson() => json.encode(
        toMap(),
      );

  factory OrderItemsEntity.fromJson(
    String source,
  ) =>
      OrderItemsEntity.fromMap(
        json.decode(
          source,
        ),
      );
}
