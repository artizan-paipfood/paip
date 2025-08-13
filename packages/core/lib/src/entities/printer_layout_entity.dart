import 'dart:convert';
import 'package:core/src/extensions/date.dart';
import 'package:core/src/exceptions/serialization_exception.dart';

class PrinterLayoutEntity {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String establishmentId;
  final String name;
  final String fontFamily;
  final List<Map<String, dynamic>> sections;
  PrinterLayoutEntity({
    required this.id,
    this.createdAt,
    this.updatedAt,
    required this.establishmentId,
    required this.name,
    required this.fontFamily,
    required this.sections,
  });

  static const String table = 'printer_layouts';

  PrinterLayoutEntity copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? establishmentId,
    String? name,
    String? fontFamily,
    List<Map<String, dynamic>>? sections,
  }) {
    return PrinterLayoutEntity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      establishmentId: establishmentId ?? this.establishmentId,
      name: name ?? this.name,
      fontFamily: fontFamily ?? this.fontFamily,
      sections: sections ?? this.sections,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt?.toPaipDB() ?? DateTime.now().toPaipDB(),
      'updated_at': updatedAt?.toPaipDB(),
      'establishment_id': establishmentId,
      'name': name,
      'font_family': fontFamily,
      'sections': sections,
    };
  }

  factory PrinterLayoutEntity.fromMap(
    Map<String, dynamic> map,
  ) {
    try {
      return PrinterLayoutEntity(
        id: map['id'] ?? '',
        createdAt: map['created_at'] != null
            ? DateTime.parse(
                map['created_at'],
              )
            : null,
        updatedAt: map['updated_at'] != null
            ? DateTime.parse(
                map['updated_at'],
              )
            : null,
        establishmentId: map['establishment_id'] ?? '',
        name: map['name'] ?? '',
        fontFamily: map['font_family'] ?? '',
        sections: List<Map<String, dynamic>>.from(
          map['sections']?.map(
            (
              x,
            ) =>
                x,
          ),
        ),
      );
    } catch (e) {
      throw SerializationException(map: map, runTimeType: 'PrinterLayoutEntity', stackTrace: StackTrace.current);
    }
  }

  String toJson() => json.encode(
        toMap(),
      );

  factory PrinterLayoutEntity.fromJson(
    String source,
  ) =>
      PrinterLayoutEntity.fromMap(
        json.decode(
          source,
        ),
      );
}
