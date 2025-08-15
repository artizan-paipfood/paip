import 'dart:convert';

import 'package:core/core.dart';

class ProductView {
  final String productId;
  final String establishmentId;
  final ProductEntity product;
  final Map<String, ComplementEntity> complements;
  final Map<String, ItemEntity> items;
  final Map<String, SizeEntity> sizes;

  ProductView({
    required this.productId,
    required this.establishmentId,
    required this.product,
    required this.complements,
    required this.items,
    required this.sizes,
  });

  factory ProductView.fromMap(Map<String, dynamic> map) {
    return ProductView(
      productId: map['product_id'] ?? '',
      establishmentId: map['establishment_id'] ?? '',
      product: ProductEntity.fromMap(map['product']),
      complements: _parseComplements(List<Map<String, dynamic>>.from(map['complements'] ?? const [])),
      items: _parseItems(List<Map<String, dynamic>>.from(map['items'] ?? const [])),
      sizes: _parseSizes(List<Map<String, dynamic>>.from(map['sizes'] ?? const [])),
    );
  }

  factory ProductView.fromJson(String source) => ProductView.fromMap(json.decode(source));

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
