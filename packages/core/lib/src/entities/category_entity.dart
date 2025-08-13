import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/src/exceptions/serialization_exception.dart';

class CategoryEntity {
  final String id;
  final String name;
  final String? description;
  final bool visible;
  final String? image;
  final int? index;
  final CategoryType categoryType;
  final bool isDeleted;
  final String establishmentId;
  CategoryEntity({
    required this.id,
    required this.name,
    required this.establishmentId,
    this.visible = true,
    this.description,
    this.image,
    this.index,
    this.categoryType = CategoryType.product,
    this.isDeleted = false,
  });

  CategoryEntity copyWith({
    String? id,
    String? name,
    String? description,
    bool? visible,
    String? image,
    int? index,
    CategoryType? categoryType,
    bool? isDeleted,
    String? establishmentId,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      visible: visible ?? this.visible,
      image: image ?? this.image,
      index: index ?? this.index,
      categoryType: categoryType ?? this.categoryType,
      isDeleted: isDeleted ?? this.isDeleted,
      establishmentId: establishmentId ?? this.establishmentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'updated_at': DateTime.now().toPaipDB(),
      'name': name,
      'description': description,
      'visible': visible,
      'image': image,
      'index': index,
      'category_type': categoryType.name,
      'is_deleted': isDeleted,
      'establishment_id': establishmentId,
    };
  }

  factory CategoryEntity.fromMap(Map<String, dynamic> map) {
    try {
      return CategoryEntity(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        establishmentId: map['establishment_id'],
        visible: map['visible'] ?? true,
        image: map['image'],
        index: map['index']?.toInt(),
        categoryType: CategoryType.fromMap(map['category_type']),
        isDeleted: map['is_deleted'] ?? false,
      );
    } catch (e) {
      throw SerializationException(map: map, runTimeType: 'CategoryEntity', stackTrace: StackTrace.current);
    }
  }

  String toJson() => json.encode(toMap());

  factory CategoryEntity.fromJson(String source) => CategoryEntity.fromMap(json.decode(source));
}
