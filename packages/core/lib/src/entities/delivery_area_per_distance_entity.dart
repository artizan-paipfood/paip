import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/src/exceptions/serialization_exception.dart';

class DeliveryAreaPerMileEntity {
  final String id;
  final String establishmentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double minDistance;
  final double minPrice;
  final double pricePerMile;
  final double floorBase;
  final double radius;
  final double price;
  final bool isDeleted;
  DeliveryAreaPerMileEntity({
    required this.id,
    required this.establishmentId,
    required this.price,
    required this.radius,
    this.createdAt,
    this.updatedAt,
    this.minDistance = 0.3,
    this.minPrice = 3.0,
    this.pricePerMile = 1.5,
    this.floorBase = 0.50,
    this.isDeleted = false,
  }) {
    if (floorBase > 1 || floorBase < 0) throw Exception('floorBase must be between 0 and 1');
  }

  DeliveryAreaPerMileEntity copyWith({
    String? id,
    String? establishmentId,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? minDistance,
    double? minPrice,
    double? pricePerMile,
    double? floorBase,
    double? radius,
    double? price,
    bool? isDeleted,
  }) {
    return DeliveryAreaPerMileEntity(
      id: id ?? this.id,
      establishmentId: establishmentId ?? this.establishmentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      minDistance: minDistance ?? this.minDistance,
      minPrice: minPrice ?? this.minPrice,
      pricePerMile: pricePerMile ?? this.pricePerMile,
      floorBase: floorBase ?? this.floorBase,
      radius: radius ?? this.radius,
      price: price ?? this.price,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'establishment_id': establishmentId,
      'updated_at': updatedAt?.toPaipDB() ?? DateTime.now().toPaipDB(),
      'min_distance': minDistance,
      'min_price': minPrice,
      'price_per_mile': pricePerMile,
      'floor_base': floorBase,
      'radius': radius,
      'price': price,
      'is_deleted': isDeleted,
    };
  }

  factory DeliveryAreaPerMileEntity.fromMap(Map<String, dynamic> map) {
    try {
      return DeliveryAreaPerMileEntity(
        id: map['id'],
        establishmentId: map['establishment_id'] ?? '',
        createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
        updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
        minDistance: map['min_distance']?.toDouble() ?? 0.0,
        minPrice: map['min_price']?.toDouble() ?? 0.0,
        pricePerMile: map['price_per_mile']?.toDouble() ?? 0.0,
        floorBase: map['floor_base']?.toDouble() ?? 0.50,
        radius: map['radius']?.toDouble() ?? 0.0,
        price: map['price']?.toDouble() ?? 0.0,
        isDeleted: map['is_deleted'] ?? false,
      );
    } catch (e) {
      throw SerializationException(map: map, runTimeType: 'DeliveryAreaPerMileEntity', stackTrace: StackTrace.current);
    }
  }

  String toJson() => json.encode(toMap());

  factory DeliveryAreaPerMileEntity.fromJson(String source) => DeliveryAreaPerMileEntity.fromMap(json.decode(source));

  double pricePerDistance({required double distance, required AppLocaleCode locale}) {
    if (distance < minDistance) return minPrice;

    final kms = distance / 1000;
    final miles = distance / 1609.34;

    double calculatedPrice;

    if (locale == AppLocaleCode.gb) {
      calculatedPrice = miles * pricePerMile;
    } else {
      calculatedPrice = kms * pricePerMile;
    }

    if (floorBase == 0) return calculatedPrice;

    return (calculatedPrice / floorBase).ceil() * floorBase;
  }
}
