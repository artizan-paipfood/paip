import 'dart:convert';

import 'package:core_flutter/core_flutter.dart';
import 'package:paipfood_package/paipfood_package.dart';

class LatLongModel {
  final String id;
  final String deliveryAreaId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String establishmentId;
  final LatLng latLng;
  bool isDeleted;
  String? city;
  LatLongModel({
    required this.id,
    required this.latLng,
    required this.establishmentId,
    required this.deliveryAreaId,
    this.createdAt,
    this.updatedAt,
    this.isDeleted = false,
    this.city,
  });
  static const String box = "lat_longs";
  LatLongModel copyWith({
    String? id,
    String? deliveryAreaId,
    DateTime? createdAt,
    String? establishmentId,
    LatLng? latLng,
    SyncState? syncState,
    bool? isDeleted,
    String? city,
  }) {
    return LatLongModel(
      id: id ?? this.id,
      deliveryAreaId: deliveryAreaId ?? this.deliveryAreaId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: DateTime.now(),
      establishmentId: establishmentId ?? this.establishmentId,
      latLng: latLng ?? this.latLng,
      isDeleted: isDeleted ?? this.isDeleted,
      city: city,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'updated_at': DateTime.now().toIso8601String(),
      'delivery_area_id': deliveryAreaId,
      'establishment_id': establishmentId,
      'lat': latLng.latitude,
      'long': latLng.longitude,
      'is_deleted': isDeleted,
      'city': Env.isDev ? city : null
    };
  }

  factory LatLongModel.fromMap(Map<String, dynamic> map) {
    return LatLongModel(
      id: map['id'],
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      deliveryAreaId: map['delivery_area_id'],
      establishmentId: map['establishment_id'],
      latLng: LatLng(
        double.parse(map['lat'].toString()),
        double.parse(map['long'].toString()),
      ),
      isDeleted: map['is_deleted'] ?? false,
      city: map['city'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LatLongModel.fromJson(String source) => LatLongModel.fromMap(json.decode(source));
}
