import 'dart:convert';

import 'package:core/src/enums/unity_measure.dart';

class ComplementItensMetadata {
  final String id;
  final int index;
  final String description;
  final String itemId;
  final String complementId;
  final double qty;
  final UnityMeasure unityMeasure;
  final double amount;
  final String? observation;
  ComplementItensMetadata({
    required this.id,
    required this.index,
    required this.description,
    required this.itemId,
    required this.complementId,
    required this.qty,
    required this.unityMeasure,
    required this.amount,
    this.observation,
  });

  ComplementItensMetadata copyWith({
    String? id,
    int? index,
    String? description,
    String? itemId,
    String? complementId,
    double? qty,
    UnityMeasure? unityMeasure,
    double? amount,
    String? observation,
  }) {
    return ComplementItensMetadata(
      id: id ?? this.id,
      index: index ?? this.index,
      description: description ?? this.description,
      itemId: itemId ?? this.itemId,
      complementId: complementId ?? this.complementId,
      qty: qty ?? this.qty,
      unityMeasure: unityMeasure ?? this.unityMeasure,
      amount: amount ?? this.amount,
      observation: observation ?? this.observation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'index': index,
      'description': description,
      'itemId': itemId,
      'complementId': complementId,
      'qty': qty,
      'unityMeasure': unityMeasure.name,
      'amount': amount,
      'observation': observation,
    };
  }

  factory ComplementItensMetadata.fromMap(
    Map<String, dynamic> map,
  ) {
    return ComplementItensMetadata(
      id: map['id'] ?? '',
      index: map['index']?.toInt() ?? 0,
      description: map['description'] ?? '',
      itemId: map['itemId'] ?? '',
      complementId: map['complementId'] ?? '',
      qty: map['qty']?.toDouble() ?? 0.0,
      unityMeasure: UnityMeasure.fromMap(
        map['unityMeasure'],
      ),
      amount: map['amount']?.toDouble() ?? 0.0,
      observation: map['observation'],
    );
  }

  String toJson() => json.encode(
        toMap(),
      );

  factory ComplementItensMetadata.fromJson(
    String source,
  ) =>
      ComplementItensMetadata.fromMap(
        json.decode(
          source,
        ),
      );
}
