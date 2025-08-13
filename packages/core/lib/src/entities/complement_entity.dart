import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/src/exceptions/serialization_exception.dart';

class ComplementEntity {
  final String id;
  final String name;
  final String identifier;
  final double qtyMin;
  final double qtyMax;
  final int? index;
  final bool visible;
  final ComplementType complementType;
  final String establishmentId;
  final bool isMultiple;
  final bool isDeleted;
  final String? idCategoryPizza;
  ComplementEntity({
    required this.id,
    required this.name,
    required this.identifier,
    required this.establishmentId,
    this.qtyMin = 0,
    this.qtyMax = 0,
    this.index,
    this.visible = true,
    this.complementType = ComplementType.item,
    this.isMultiple = false,
    this.isDeleted = false,
    this.idCategoryPizza,
  });

  ComplementEntity copyWith({
    String? id,
    String? name,
    String? identifier,
    double? qtyMin,
    double? qtyMax,
    int? index,
    bool? visible,
    ComplementType? complementType,
    String? establishmentId,
    bool? isMultiple,
    bool? isDeleted,
    String? idCategoryPizza,
  }) {
    return ComplementEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      identifier: identifier ?? this.identifier,
      qtyMin: qtyMin ?? this.qtyMin,
      qtyMax: qtyMax ?? this.qtyMax,
      index: index ?? this.index,
      visible: visible ?? this.visible,
      complementType: complementType ?? this.complementType,
      establishmentId: establishmentId ?? this.establishmentId,
      isMultiple: isMultiple ?? this.isMultiple,
      isDeleted: isDeleted ?? this.isDeleted,
      idCategoryPizza: idCategoryPizza ?? this.idCategoryPizza,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'updated_at': DateTime.now().toPaipDB(),
      'identifier': identifier,
      'qty_min': qtyMin,
      'qty_max': qtyMax,
      'index': index,
      'visible': visible,
      'complementType': complementType.name,
      'establishment_id': establishmentId,
      'is_multiple': isMultiple,
      'is_deleted': isDeleted,
      'id_category_pizza': idCategoryPizza,
    };
  }

  factory ComplementEntity.fromMap(Map<String, dynamic> map) {
    try {
      return ComplementEntity(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        identifier: map['identifier'] ?? '',
        qtyMin: map['qty_min']?.toDouble() ?? 0.0,
        qtyMax: map['qty_max']?.toDouble() ?? 0.0,
        index: map['index']?.toInt(),
        visible: map['visible'] ?? false,
        complementType: ComplementType.fromMap(map['complement_type']),
        establishmentId: map['establishment_id'] ?? '',
        isMultiple: map['is_multiple'] ?? false,
        isDeleted: map['is_deleted'] ?? false,
        idCategoryPizza: map['id_category_pizza'],
      );
    } catch (e) {
      throw SerializationException(map: map, runTimeType: 'ComplementEntity', stackTrace: StackTrace.current);
    }
  }

  String toJson() => json.encode(toMap());

  factory ComplementEntity.fromJson(String source) => ComplementEntity.fromMap(json.decode(source));
}
