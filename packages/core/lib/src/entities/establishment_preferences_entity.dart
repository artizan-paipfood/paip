import 'dart:convert';
import 'package:core/core.dart';

class EstablishmentPreferencesEntity {
  final String establishmentId;
  final DateTime updatedAt;
  final int resetOrderNumberReference;
  final DateTime? resetOrderNumberAt;
  final ResetOrderNumberPeriod resetOrderNumberPeriod;
  final bool automaticAcceptOrders;
  final bool enableSchedule;
  final bool enableScheduleTomorrow;
  final bool enableWhatsapp;
  EstablishmentPreferencesEntity({
    required this.establishmentId,
    DateTime? updatedAt,
    this.resetOrderNumberReference = 0,
    DateTime? resetOrderNumberAt,
    this.resetOrderNumberPeriod = ResetOrderNumberPeriod.monthly,
    this.automaticAcceptOrders = false,
    this.enableSchedule = false,
    this.enableScheduleTomorrow = false,
    this.enableWhatsapp = true,
  })  : resetOrderNumberAt = resetOrderNumberAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  static const String table = 'establishment_preferences';

  EstablishmentPreferencesEntity copyWith({
    String? establishmentId,
    DateTime? updatedAt,
    int? resetOrderNumberReference,
    DateTime? resetOrderNumberAt,
    ResetOrderNumberPeriod? resetOrderNumberPeriod,
    bool? automaticAcceptOrders,
    bool? enableSchedule,
    bool? enableScheduleTomorrow,
    bool? enableWhatsapp,
  }) {
    return EstablishmentPreferencesEntity(
      establishmentId: establishmentId ?? this.establishmentId,
      updatedAt: updatedAt ?? this.updatedAt,
      resetOrderNumberReference: resetOrderNumberReference ?? this.resetOrderNumberReference,
      resetOrderNumberAt: resetOrderNumberAt ?? this.resetOrderNumberAt,
      resetOrderNumberPeriod: resetOrderNumberPeriod ?? this.resetOrderNumberPeriod,
      automaticAcceptOrders: automaticAcceptOrders ?? this.automaticAcceptOrders,
      enableSchedule: enableSchedule ?? this.enableSchedule,
      enableScheduleTomorrow: enableScheduleTomorrow ?? this.enableScheduleTomorrow,
      enableWhatsapp: enableWhatsapp ?? this.enableWhatsapp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'establishment_id': establishmentId,
      'updated_at': updatedAt.toPaipDB(),
      'reset_order_number_reference': resetOrderNumberReference,
      'reset_order_number_at': resetOrderNumberAt?.toPaipDB(),
      'reset_order_number_period': resetOrderNumberPeriod.name,
      'automatic_accept_orders': automaticAcceptOrders,
      'enable_schedule': enableSchedule,
      'enable_schedule_tomorrow': enableScheduleTomorrow,
      'enable_whatsapp': enableWhatsapp,
    };
  }

  factory EstablishmentPreferencesEntity.fromMap(Map<String, dynamic> map) {
    return EstablishmentPreferencesEntity(
      establishmentId: map['establishment_id'] ?? '',
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      resetOrderNumberReference: map['reset_order_number_reference']?.toInt() ?? 0,
      resetOrderNumberAt: map['reset_order_number_at'] != null ? DateTime.parse(map['reset_order_number_at']) : null,
      resetOrderNumberPeriod: ResetOrderNumberPeriod.fromMap(map['reset_order_number_period']),
      automaticAcceptOrders: map['automatic_accept_orders'] ?? false,
      enableSchedule: map['enable_schedule'] ?? false,
      enableScheduleTomorrow: map['enable_schedule_tomorrow'] ?? false,
      enableWhatsapp: map['enable_whatsapp'] ?? true,
    );
  }

  String toJson() => json.encode(toMap());

  factory EstablishmentPreferencesEntity.fromJson(String source) => EstablishmentPreferencesEntity.fromMap(json.decode(source));

  //*******************************************************
  // custom methods
  //*******************************************************

  bool needResetOrderNumber() {
    return resetOrderNumberAt == null || resetOrderNumberAt!.normalizeToCondition().isBefore(DateTime.now());
  }
}
