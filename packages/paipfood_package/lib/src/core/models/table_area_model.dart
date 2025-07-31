import 'dart:convert';

import 'package:paipfood_package/paipfood_package.dart';

class TableAreaModel {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String name;
  final String establishmentId;
  TableAreaModel({
    required this.id,
    required this.establishmentId,
    this.createdAt,
    this.updatedAt,
    this.name = '',
  });

  static String box = 'table_areas';

  TableAreaModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? establishmentId,
  }) {
    return TableAreaModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      name: name ?? this.name,
      establishmentId: establishmentId ?? this.establishmentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'updated_at': DateTime.now().pToTimesTamptzFormat(),
      'name': name,
      'establishment_id': establishmentId,
    };
  }

  factory TableAreaModel.fromMap(Map<String, dynamic> map) {
    return TableAreaModel(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      name: map['name'],
      establishmentId: map['establishment_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TableAreaModel.fromJson(String source) => TableAreaModel.fromMap(json.decode(source));
}
