import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/src/exceptions/serialization_exception.dart';

class ItemEntity {
  final String id;
  final String name;
  final String? nickName;
  final String? description;
  final double? price;
  final double? promotionalPrice;
  final bool isPromotional;
  final bool isPreselected;
  final bool visible;
  final int? index;
  final ItemType itemType;
  final String establishmentId;
  final String complementId;
  final bool isDeleted;
  final double? priceFrom;
  final String? image;
  final String? imageCacheKey;
  ItemEntity({
    required this.id,
    required this.name,
    this.nickName,
    this.description,
    this.price,
    this.promotionalPrice,
    this.isPromotional = false,
    this.isPreselected = false,
    this.visible = true,
    this.index,
    this.itemType = ItemType.item,
    required this.establishmentId,
    required this.complementId,
    this.isDeleted = false,
    this.priceFrom,
    this.image,
    this.imageCacheKey,
  });

  ItemEntity copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? nickName,
    String? description,
    double? price,
    double? promotionalPrice,
    bool? isPromotional,
    bool? isPreselected,
    bool? visible,
    int? index,
    ItemType? itemType,
    String? establishmentId,
    String? complementId,
    bool? isDeleted,
    double? priceFrom,
    String? image,
    String? imageCacheKey,
  }) {
    return ItemEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      nickName: nickName ?? this.nickName,
      description: description ?? this.description,
      price: price ?? this.price,
      promotionalPrice: promotionalPrice ?? this.promotionalPrice,
      isPromotional: isPromotional ?? this.isPromotional,
      isPreselected: isPreselected ?? this.isPreselected,
      visible: visible ?? this.visible,
      index: index ?? this.index,
      itemType: itemType ?? this.itemType,
      establishmentId: establishmentId ?? this.establishmentId,
      complementId: complementId ?? this.complementId,
      isDeleted: isDeleted ?? this.isDeleted,
      priceFrom: priceFrom ?? this.priceFrom,
      image: image ?? this.image,
      imageCacheKey: imageCacheKey ?? this.imageCacheKey,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'updated_at': DateTime.now().toPaipDB(),
      'name': name,
      'nick_name': nickName,
      'description': description,
      'price': price,
      'promotional_price': promotionalPrice,
      'is_promotional': isPromotional,
      'is_preselected': isPreselected,
      'visible': visible,
      'index': index,
      'item_type': itemType.name,
      'establishment_id': establishmentId,
      'complement_id': complementId,
      'is_deleted': isDeleted,
      'price_from': priceFrom,
      'image': image,
      'image_cache_key': imageCacheKey,
    };
  }

  factory ItemEntity.fromMap(Map<String, dynamic> map) {
    try {
      return ItemEntity(
        id: map['id'],
        name: map['name'],
        nickName: map['nick_name'],
        description: map['description'],
        price: map['price']?.toDouble(),
        promotionalPrice: map['promotional_price']?.toDouble(),
        isPromotional: map['is_promotional'] ?? false,
        isPreselected: map['is_preselected'] ?? false,
        visible: map['visible'] ?? true,
        index: map['index']?.toInt(),
        itemType: ItemType.fromMap(map['item_type']),
        establishmentId: map['establishment_id'] ?? '',
        complementId: map['complement_id'] ?? '',
        isDeleted: map['is_deleted'] ?? false,
        priceFrom: map['price_from']?.toDouble(),
        image: map['image'],
        imageCacheKey: map['image_cache_key'],
      );
    } catch (e) {
      throw SerializationException(map: map, runTimeType: 'ItemEntity', stackTrace: StackTrace.current);
    }
  }

  String toJson() => json.encode(toMap());

  factory ItemEntity.fromJson(String source) => ItemEntity.fromMap(json.decode(source));

  double get finalPrice => promotionalPrice ?? price ?? 0;
}
