import 'dart:convert';

import 'package:core/src/exceptions/serialization_exception.dart';

class EstablishmentPlanEntity {
  final String id;
  DateTime? createdAt;
  final double? fixedPrice;
  final double? discount;
  final double? promotionalPrice;
  final DateTime? promotionalPriceValidUntil;
  final String establishmentId;
  final String planId;
  final int billingDay;
  final double price;
  EstablishmentPlanEntity({
    required this.id,
    required this.establishmentId,
    required this.planId,
    required this.billingDay,
    required this.price,
    this.createdAt,
    this.fixedPrice,
    this.discount,
    this.promotionalPrice,
    this.promotionalPriceValidUntil,
  });

  EstablishmentPlanEntity copyWith({
    String? id,
    DateTime? createdAt,
    double? fixedPrice,
    double? discount,
    double? promotionalPrice,
    DateTime? promotionalPriceValidUntil,
    String? establishmentId,
    String? planId,
    int? billingDay,
    double? price,
  }) {
    return EstablishmentPlanEntity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      fixedPrice: fixedPrice ?? this.fixedPrice,
      discount: discount ?? this.discount,
      promotionalPrice: promotionalPrice ?? this.promotionalPrice,
      promotionalPriceValidUntil: promotionalPriceValidUntil ?? this.promotionalPriceValidUntil,
      establishmentId: establishmentId ?? this.establishmentId,
      planId: planId ?? this.planId,
      billingDay: billingDay ?? this.billingDay,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fixed_price': fixedPrice,
      'discount': discount,
      'promotional_price': promotionalPrice,
      'promotional_price_valid_until': promotionalPriceValidUntil?.millisecondsSinceEpoch,
      'establishment_id': establishmentId,
      'plan_id': planId,
      'billing_day': billingDay,
      'price': price,
    };
  }

  factory EstablishmentPlanEntity.fromMap(Map<String, dynamic> map) {
    try {
      return EstablishmentPlanEntity(
        id: map['id'],
        createdAt: DateTime.parse(map['created_at']),
        fixedPrice: map['fixedPrice']?.toDouble(),
        discount: map['discount']?.toDouble(),
        promotionalPrice: map['promotional_price']?.toDouble(),
        promotionalPriceValidUntil: map['promotional_price_valid_until'] != null ? DateTime.parse(map['promotional_price_valid_until']) : null,
        establishmentId: map['establishment_id'] ?? '',
        planId: map['plan_id'] ?? '',
        billingDay: map['billing_day']?.toInt() ?? 0,
        price: map['price']?.toDouble() ?? 0.0,
      );
    } catch (e) {
      throw SerializationException(map: map, runTimeType: 'EstablishmentPlanEntity', stackTrace: StackTrace.current);
    }
  }

  String toJson() => json.encode(toMap());

  factory EstablishmentPlanEntity.fromJson(String source) => EstablishmentPlanEntity.fromMap(json.decode(source));

  //----------------------------------------------------------------------------
  // methods
  //----------------------------------------------------------------------------

  double buildAmount() {
    if (fixedPrice != null) return fixedPrice!;
    if (promotionalPrice != null && (promotionalPriceValidUntil?.isAfter(DateTime.now()) ?? false)) {
      return promotionalPrice!;
    }
    if (discount != null) {
      return price - discount!;
    }
    return price;
  }
}
