import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/src/exceptions/serialization_exception.dart';

class SizeEntity {
  final String id;

  final String name;
  final String? description;
  final double? price;
  final double? promotionalPrice;
  final String establishmentId;
  final String? productId;
  final String? itemId;
  final bool isPreselected;
  final bool isDeleted;
  final SizeType sizeType;
  SizeEntity({
    required this.id,
    required this.name,
    required this.establishmentId,
    this.description,
    this.price,
    this.promotionalPrice,
    this.productId,
    this.itemId,
    this.isPreselected = false,
    this.isDeleted = false,
    this.sizeType = SizeType.product,
  });

  SizeEntity copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? promotionalPrice,
    String? establishmentId,
    String? productId,
    String? itemId,
    bool? isPreselected,
    bool? isDeleted,
    SizeType? sizeType,
  }) {
    return SizeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      promotionalPrice: promotionalPrice ?? this.promotionalPrice,
      establishmentId: establishmentId ?? this.establishmentId,
      productId: productId ?? this.productId,
      itemId: itemId ?? this.itemId,
      isPreselected: isPreselected ?? this.isPreselected,
      isDeleted: isDeleted ?? this.isDeleted,
      sizeType: sizeType ?? this.sizeType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'updated_at': DateTime.now().toPaipDB(),
      'name': name,
      'description': description,
      'price': price,
      'promotional_price': promotionalPrice,
      'establishment_id': establishmentId,
      'product_id': productId,
      'item_id': itemId,
      'is_preselected': isPreselected,
      'is_deleted': isDeleted,
      'size_type': sizeType.name,
    };
  }

  factory SizeEntity.fromMap(Map<String, dynamic> map) {
    try {
      return SizeEntity(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        description: map['description'],
        price: map['price']?.toDouble(),
        promotionalPrice: map['promotional_price']?.toDouble(),
        establishmentId: map['establishment_id'] ?? '',
        productId: map['product_id'],
        itemId: map['item_id'],
        isPreselected: map['is_preselected'] ?? false,
        isDeleted: map['is_deleted'] ?? false,
        sizeType: SizeType.fromMap(map['size_type']),
      );
    } catch (e) {
      throw SerializationException(map: map, runTimeType: 'SizeEntity', stackTrace: StackTrace.current);
    }
  }

  String toJson() => json.encode(toMap());

  factory SizeEntity.fromJson(String source) => SizeEntity.fromMap(json.decode(source));
}
