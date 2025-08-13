import 'dart:convert';

import 'package:core/core.dart';

class OpeningHoursEntity {
  final String id;
  final int weekDayId;
  final DateTime openningDate; // TODO: TA ESCRITO ERRADO
  final DateTime closingDate;
  final String establishmentId;
  final HoursEnum openingEnumValue;
  final HoursEnum closingEnumValue;
  OpeningHoursEntity({
    required this.id,
    required this.weekDayId,
    required this.openningDate,
    required this.closingDate,
    required this.establishmentId,
    required this.openingEnumValue,
    required this.closingEnumValue,
  });

  OpeningHoursEntity copyWith({
    String? id,
    int? weekDayId,
    DateTime? openningDate,
    DateTime? closingDate,
    String? establishmentId,
    HoursEnum? openingEnumValue,
    HoursEnum? closingEnumValue,
  }) {
    return OpeningHoursEntity(
      id: id ?? this.id,
      weekDayId: weekDayId ?? this.weekDayId,
      openningDate: openningDate ?? this.openningDate,
      closingDate: closingDate ?? this.closingDate,
      establishmentId: establishmentId ?? this.establishmentId,
      openingEnumValue: openingEnumValue ?? this.openingEnumValue,
      closingEnumValue: closingEnumValue ?? this.closingEnumValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'updated_at': DateTime.now().toPaipDB(),
      'week_day_id': weekDayId,
      'openning_date': openningDate.toPaipDB(),
      'closing_date': closingDate.toPaipDB(),
      'establishment_id': establishmentId,
      'opening_enum_value': openingEnumValue,
      'closing_enum_value': closingEnumValue,
    };
  }

  factory OpeningHoursEntity.fromMap(Map<String, dynamic> map) {
    return OpeningHoursEntity(
      id: map['id'] ?? '',
      weekDayId: map['week_day_id']?.toInt() ?? 0,
      openningDate: DateTime.parse(map['openning_date']),
      closingDate: DateTime.parse(map['closing_date']),
      establishmentId: map['establishment_id'] ?? '',
      openingEnumValue: HoursEnum.values.firstWhere((e) => e.value == map['opening_enum_value']),
      closingEnumValue: HoursEnum.values.firstWhere((e) => e.value == map['closing_enum_value']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OpeningHoursEntity.fromJson(String source) => OpeningHoursEntity.fromMap(json.decode(source));
}
