import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/src/exceptions/serialization_exception.dart';

class ProductEntity {
  final String id;
  final String name;
  final String? description;
  final double? price;
  final double? promotionalPrice;
  final bool isPromotional;
  final bool visible;
  final int? qtyFlavorPizza;
  final String? image;
  final int? index;

  final String categoryId;
  final String establishmentId;
  final List<String> complementsIds;
  final bool isDeleted;
  final double? priceFrom;
  final bool isPizza;
  final String? imageCacheKey;

  ProductEntity({
    required this.id,
    required this.name,
    this.isPromotional = false,
    this.visible = true,
    required this.categoryId,
    required this.establishmentId,
    this.complementsIds = const [],
    this.isDeleted = false,
    this.isPizza = false,
    this.imageCacheKey,
    this.description,
    this.price,
    this.promotionalPrice,
    this.qtyFlavorPizza,
    this.image,
    this.index,
    this.priceFrom,
  });

  ProductEntity copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? promotionalPrice,
    bool? isPromotional,
    bool? visible,
    int? qtyFlavorPizza,
    String? image,
    int? index,
    String? categoryId,
    String? establishmentId,
    List<String>? complementsIds,
    bool? isDeleted,
    double? priceFrom,
    bool? isPizza,
    String? imageCacheKey,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      promotionalPrice: promotionalPrice ?? this.promotionalPrice,
      isPromotional: isPromotional ?? this.isPromotional,
      visible: visible ?? this.visible,
      qtyFlavorPizza: qtyFlavorPizza ?? this.qtyFlavorPizza,
      image: image ?? this.image,
      index: index ?? this.index,
      categoryId: categoryId ?? this.categoryId,
      establishmentId: establishmentId ?? this.establishmentId,
      complementsIds: complementsIds ?? this.complementsIds,
      isDeleted: isDeleted ?? this.isDeleted,
      priceFrom: priceFrom ?? this.priceFrom,
      isPizza: isPizza ?? this.isPizza,
      imageCacheKey: imageCacheKey ?? this.imageCacheKey,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'promotional_price': promotionalPrice,
      'is_promotional': isPromotional,
      'visible': visible,
      'qty_flavor_pizza': qtyFlavorPizza,
      'image': image,
      'index': index,
      'updated_at': DateTime.now().toPaipDB(),
      'category_id': categoryId,
      'establishment_id': establishmentId,
      'complements_ids': complementsIds,
      'is_deleted': isDeleted,
      'price_from': priceFrom,
      'is_pizza': isPizza,
      'image_cache_key': imageCacheKey,
    };
  }

  factory ProductEntity.fromMap(Map<String, dynamic> map) {
    try {
      return ProductEntity(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        price: map['price']?.toDouble(),
        promotionalPrice: map['promotional_price']?.toDouble(),
        isPromotional: map['is_promotional'] ?? false,
        visible: map['visible'] ?? true,
        qtyFlavorPizza: map['qty_flavor_pizza']?.toInt(),
        image: map['image'],
        index: map['index']?.toInt(),
        categoryId: map['category_id'] ?? '',
        establishmentId: map['establishment_id'] ?? '',
        complementsIds: List<String>.from(map['complements_ids']),
        isDeleted: map['is_deleted'] ?? false,
        priceFrom: map['price_from']?.toDouble(),
        isPizza: map['is_pizza'] ?? false,
        imageCacheKey: map['image_cache_key'],
      );
    } catch (e) {
      throw SerializationException(map: map, runTimeType: 'ProductEntity', stackTrace: StackTrace.current);
    }
  }

  String toJson() => json.encode(toMap());

  factory ProductEntity.fromJson(String source) => ProductEntity.fromMap(json.decode(source));
}
