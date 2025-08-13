import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/src/exceptions/serialization_exception.dart';
import 'package:core/src/extensions/date.dart';

class DeliveryAreaEntity {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String color;
  final String label;
  final double price;
  final bool isDeleted;
  final String establishmentId;
  final String? city;
  DeliveryAreaEntity({
    required this.id,
    required this.establishmentId,
    this.createdAt,
    this.updatedAt,
    this.color = '4293284096',
    this.label = '',
    this.price = 0.0,
    this.isDeleted = false,
    this.city,
  });

  static const String table = 'delivery_areas';

  DeliveryAreaEntity copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? color,
    String? label,
    double? price,
    bool? isDeleted,
    String? id,
    String? establishmentId,
    String? city,
  }) {
    return DeliveryAreaEntity(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      color: color ?? this.color,
      label: label ?? this.label,
      price: price ?? this.price,
      isDeleted: isDeleted ?? this.isDeleted,
      id: id ?? this.id,
      establishmentId: establishmentId ?? this.establishmentId,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'created_at': createdAt?.toPaipDB(),
      'updated_at': updatedAt?.toPaipDB(),
      'color': color,
      'label': label,
      'price': price,
      'is_deleted': isDeleted,
      'id': id,
      'establishment_id': establishmentId,
      'city': city,
    };
  }

  factory DeliveryAreaEntity.fromMap(
    Map<String, dynamic> map,
  ) {
    try {
      return DeliveryAreaEntity(
        createdAt: map['created_at'] != null
            ? DateTime.parse(
                map['created_at'],
              )
            : null,
        updatedAt: map['updated_at'] != null
            ? DateTime.parse(
                map['updated_at'],
              )
            : null,
        color: map['color'] ?? '',
        label: map['label'] ?? '',
        price: map['price']?.toDouble() ?? 0.0,
        isDeleted: map['is_deleted'] ?? false,
        id: map['id'] ?? '',
        establishmentId: map['establishment_id'] ?? '',
        city: map['city'],
      );
    } catch (e) {
      throw SerializationException(map: map, runTimeType: 'DeliveryAreaEntity', stackTrace: StackTrace.current);
    }
  }

  String toJson() => json.encode(
        toMap(),
      );

  factory DeliveryAreaEntity.fromJson(
    String source,
  ) =>
      DeliveryAreaEntity.fromMap(
        json.decode(
          source,
        ),
      );
}
