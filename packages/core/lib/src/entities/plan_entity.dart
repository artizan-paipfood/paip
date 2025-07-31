import 'dart:convert';

import 'package:core/core.dart';

class PlanEntity {
  final String id;
  final DateTime createdAt;
  final double price;
  final double? promotionalPrice;
  final double? discountValue;
  final int? promotionDurationInDays;
  final bool enable;
  final Plan plan;
  final DbLocale locale;
  PlanEntity({
    required this.id,
    required this.createdAt,
    required this.price,
    this.promotionalPrice,
    this.discountValue,
    this.promotionDurationInDays,
    required this.enable,
    required this.plan,
    required this.locale,
  });

  static const String table = 'plans';

  PlanEntity copyWith({
    String? id,
    DateTime? createdAt,
    double? price,
    double? promotionalPrice,
    double? discountValue,
    int? promotionDurationInDays,
    bool? enable,
    Plan? plan,
    DbLocale? locale,
  }) {
    return PlanEntity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      price: price ?? this.price,
      promotionalPrice: promotionalPrice ?? this.promotionalPrice,
      discountValue: discountValue ?? this.discountValue,
      promotionDurationInDays: promotionDurationInDays ?? this.promotionDurationInDays,
      enable: enable ?? this.enable,
      plan: plan ?? this.plan,
      locale: locale ?? this.locale,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'price': price,
      'promotional_price': promotionalPrice,
      'discount_value': discountValue,
      'promotion_duration_in_days': promotionDurationInDays,
      'enable': enable,
      'plan': plan.name,
      'locale': locale.name,
    };
  }

  factory PlanEntity.fromMap(
    Map<String, dynamic> map,
  ) {
    return PlanEntity(
      id: map['id'] ?? '',
      createdAt: DateTime.parse(
        map['createdAt'],
      ),
      price: map['price']?.toDouble() ?? 0.0,
      promotionalPrice: map['promotional_price']?.toDouble(),
      discountValue: map['discount_value']?.toDouble(),
      promotionDurationInDays: map['promotion_duration_in_days']?.toInt(),
      enable: map['enable'] ?? false,
      plan: Plan.values.byName(
        map['plan'],
      ),
      locale: DbLocale.values.byName(
        map['locale'],
      ),
    );
  }

  String toJson() => json.encode(
        toMap(),
      );

  factory PlanEntity.fromJson(
    String source,
  ) =>
      PlanEntity.fromMap(
        json.decode(
          source,
        ),
      );
}
