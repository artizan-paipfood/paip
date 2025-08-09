import 'dart:convert';

import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';

class DeliveryAreaModel {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  Color color;
  String label;
  double price;
  bool isDeleted;
  final String establishmentId;
  String? city;

  List<LatLongModel> latLongs;

  DeliveryAreaModel({
    required this.establishmentId,
    required this.latLongs,
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.color = Colors.red,
    this.label = '',
    this.price = 0.0,
    this.isDeleted = false,
    this.city,
  });
  static const String box = "delivery_areas";

  DeliveryAreaModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Color? color,
    String? label,
    double? price,
    bool? isDeleted,
    String? establishmentId,
    String? city,
    List<LatLongModel>? latLongs,
  }) {
    return DeliveryAreaModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      color: color ?? this.color,
      label: label ?? this.label,
      price: price ?? this.price,
      isDeleted: isDeleted ?? this.isDeleted,
      establishmentId: establishmentId ?? this.establishmentId,
      city: city ?? this.city,
      latLongs: latLongs ?? this.latLongs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'updated_at': DateTime.now().toIso8601String(),
      'establishment_id': establishmentId,
      'color': color.value,
      'label': label,
      'price': price,
      'is_deleted': isDeleted,
      'city': Env.isDev ? city : null,
    };
  }

  factory DeliveryAreaModel.fromMap(Map<String, dynamic> map) {
    return DeliveryAreaModel(
      id: map['id'],
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      establishmentId: map['establishment_id'],
      color: map['color'] != null ? Color(int.parse(map['color'].toString())) : Colors.red,
      label: map['label'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      latLongs: [],
      isDeleted: map['is_deleted'] ?? false,
      city: map['city'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryAreaModel.fromJson(String source) => DeliveryAreaModel.fromMap(json.decode(source));

  factory DeliveryAreaModel.fromWaiterDriver(Map<String, dynamic> map) {
    return DeliveryAreaModel(
      id: map['id'] ?? '',
      establishmentId: map['establishment_id'] ?? '',
      price: map['fee'] / 100,
      latLongs: [],
    );
  }
}
