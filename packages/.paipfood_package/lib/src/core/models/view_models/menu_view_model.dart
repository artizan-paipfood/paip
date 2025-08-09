import 'dart:convert';

import 'package:paipfood_package/paipfood_package.dart';

class MenuDto {
  final Map<String, CategoryModel> categories;
  final Map<String, ProductModel> products;
  final Map<String, ComplementModel> complements;
  final Map<String, ItemModel> items;
  final Map<String, SizeModel> sizes;
  MenuDto({
    this.categories = const {},
    this.products = const {},
    this.complements = const {},
    this.items = const {},
    this.sizes = const {},
  });
  static String get box => 'menu_dto';
  MenuDto copyWith({
    Map<String, CategoryModel>? categories,
    Map<String, ProductModel>? products,
    Map<String, ComplementModel>? complements,
    Map<String, ItemModel>? items,
    Map<String, SizeModel>? sizes,
  }) {
    return MenuDto(
      categories: categories ?? this.categories,
      products: products ?? this.products,
      complements: complements ?? this.complements,
      items: items ?? this.items,
      sizes: sizes ?? this.sizes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categories': categories.map((key, value) => MapEntry(key, value.toMap())),
      'products': products.map((key, value) => MapEntry(key, value.toMap())),
      'complements': complements.map((key, value) => MapEntry(key, value.toMap())),
      'items': items.map((key, value) => MapEntry(key, value.toMap())),
      'sizes': sizes.map((key, value) => MapEntry(key, value.toMap())),
    };
  }

  factory MenuDto.fromMap(Map map) {
    return MenuDto(
      categories: Map<String, CategoryModel>.from(map['categories'] ?? const {}),
      products: Map<String, ProductModel>.from(map['products'] ?? const {}),
      complements: Map<String, ComplementModel>.from(map['complements'] ?? const {}),
      items: Map<String, ItemModel>.from(map['items'] ?? const {}),
      sizes: Map<String, SizeModel>.from(map['sizes'] ?? const {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuDto.fromJson(String source) => MenuDto.fromMap(json.decode(source));
}
