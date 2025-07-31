import 'dart:convert';

class UpdateQueusEntity {
  final String establishmentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String table;
  final String operation;
  final Map<String, dynamic> data;
  UpdateQueusEntity({
    required this.establishmentId,
    DateTime? createdAt,
    DateTime? updatedAt,
    required this.table,
    required this.operation,
    required this.data,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  static const String tableDB = 'update_queus';

  UpdateQueusEntity copyWith({
    String? establishmentId,
    String? table,
    String? operation,
    Map<String, dynamic>? data,
  }) {
    return UpdateQueusEntity(
      establishmentId: establishmentId ?? this.establishmentId,
      createdAt: createdAt,
      updatedAt: DateTime.now().toLocal(),
      table: table ?? this.table,
      operation: operation ?? this.operation,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'establishment_id': establishmentId,
      'created_at': createdAt.toLocal().toIso8601String(),
      'updated_at': updatedAt.toLocal().toIso8601String(),
      'table': table,
      'operation': operation,
      'data': data,
    };
  }

  factory UpdateQueusEntity.fromMap(Map<String, dynamic> map) {
    return UpdateQueusEntity(
      establishmentId: map['establishment_id'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      table: map['table'] ?? '',
      operation: map['operation'] ?? '',
      data: Map<String, dynamic>.from(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateQueusEntity.fromJson(String source) => UpdateQueusEntity.fromMap(json.decode(source));
}
