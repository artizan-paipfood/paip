import 'dart:convert';
import 'package:core/src/entities/category_entity.dart';
import 'package:core/src/entities/complement_entity.dart';
import 'package:core/src/entities/item_entity.dart';
import 'package:core/src/entities/product_entity.dart';
import 'package:core/src/entities/size_entity.dart';
import 'package:core/src/exceptions/serialization_exception.dart';

class MenuView {
  final Map<String, CategoryEntity> categories;
  final Map<String, ProductEntity> products;
  final Map<String, ComplementEntity> complements;
  final Map<String, ItemEntity> items;
  final Map<String, SizeEntity> sizes;
  MenuView({
    this.categories = const {},
    this.products = const {},
    this.complements = const {},
    this.items = const {},
    this.sizes = const {},
  });

  factory MenuView.fromMap(Map map) {
    try {
      return MenuView(
        categories: _parseCategories(List<Map<String, dynamic>>.from(map['categories'] ?? const [])),
        products: _parseProducts(List<Map<String, dynamic>>.from(map['products'] ?? const [])),
        complements: _parseComplements(List<Map<String, dynamic>>.from(map['complements'] ?? const [])),
        items: _parseItems(List<Map<String, dynamic>>.from(map['items'] ?? const [])),
        sizes: _parseSizes(List<Map<String, dynamic>>.from(map['sizes'] ?? const [])),
      );
    } catch (e) {
      throw SerializationException(map: map, runTimeType: 'MenuViewMapper', stackTrace: StackTrace.current);
    }
  }

  factory MenuView.fromJson(String source) => MenuView.fromMap(json.decode(source));

  static Map<String, CategoryEntity> _parseCategories(List<Map<String, dynamic>> categories) {
    final result = <String, CategoryEntity>{};
    for (final category in categories) {
      result[category['id']] = CategoryEntity.fromMap(category);
    }
    return result;
  }

  static Map<String, ProductEntity> _parseProducts(List<Map<String, dynamic>> products) {
    final result = <String, ProductEntity>{};
    for (final product in products) {
      result[product['id']] = ProductEntity.fromMap(product);
    }
    return result;
  }

  static Map<String, ComplementEntity> _parseComplements(List<Map<String, dynamic>> complements) {
    final result = <String, ComplementEntity>{};
    for (final complement in complements) {
      result[complement['id']] = ComplementEntity.fromMap(complement);
    }
    return result;
  }

  static Map<String, ItemEntity> _parseItems(List<Map<String, dynamic>> items) {
    final result = <String, ItemEntity>{};
    for (final item in items) {
      result[item['id']] = ItemEntity.fromMap(item);
    }
    return result;
  }

  static Map<String, SizeEntity> _parseSizes(List<Map<String, dynamic>> sizes) {
    final result = <String, SizeEntity>{};
    for (final size in sizes) {
      result[size['id']] = SizeEntity.fromMap(size);
    }
    return result;
  }
}
