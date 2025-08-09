import 'dart:convert';

import 'package:paipfood_package/paipfood_package.dart';

class EstablishmentPlanModel {
  final String id;
  final DateTime createdAt;
  final double? fixedPrice;
  final double? discount;
  final double? promotionalPrice;
  final DateTime? promotionalPriceValidUntil;
  final Map extras;
  final String establishmentId;
  final String planId;
  final int billingDay;
  final double price;
  EstablishmentPlanModel({
    required this.id,
    required this.planId,
    required this.createdAt,
    required this.price,
    this.promotionalPriceValidUntil,
    this.establishmentId = '',
    this.billingDay = 10,
    this.discount,
    this.fixedPrice,
    this.extras = const {},
    this.promotionalPrice,
  });

  EstablishmentPlanModel copyWith({
    String? id,
    DateTime? createdAt,
    double? fixedPrice,
    double? discount,
    DateTime? promotionalPriceValidUntil,
    Map? extras,
    String? establishmentId,
    String? planId,
    int? billingDay,
    double? price,
  }) {
    return EstablishmentPlanModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      fixedPrice: fixedPrice ?? this.fixedPrice,
      discount: discount ?? this.discount,
      promotionalPriceValidUntil: promotionalPriceValidUntil ?? this.promotionalPriceValidUntil,
      extras: extras ?? this.extras,
      establishmentId: establishmentId ?? this.establishmentId,
      planId: planId ?? this.planId,
      billingDay: billingDay ?? this.billingDay,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'establishment_id': establishmentId,
      'price': price,
      'fixed_price': fixedPrice,
      'discount': discount,
      'promotional_price_valid_until': promotionalPriceValidUntil?.pToTimesTamptzFormat(),
      'plan_id': planId,
      'billing_day': billingDay,
      'extras': extras,
      'promotional_price': promotionalPrice,
    };
  }

  factory EstablishmentPlanModel.fromMap(Map map) {
    return EstablishmentPlanModel(
      id: map['id'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
      establishmentId: map['establishment_id'] ?? '',
      price: map['price'].toDouble(),
      fixedPrice: map['fixed_price']?.toDouble() ?? 0.0,
      discount: map['discount']?.toDouble() ?? 0.0,
      promotionalPriceValidUntil: map['promotional_price_valid_until'] != null ? DateTime.parse(map['promotional_price_valid_until']) : null,
      planId: map['plan_id'] ?? '',
      billingDay: map['billing_day']?.toInt() ?? 0,
      extras: map['extras'] ?? {},
      promotionalPrice: map['promotional_price']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory EstablishmentPlanModel.fromJson(String source) => EstablishmentPlanModel.fromMap(json.decode(source));
  double get buildAmount {
    if (fixedPrice != null && fixedPrice! > 0) return fixedPrice!;
    double total = price;
    total -= discount ?? 0.0;
    //TODO: @eduardohr-muniz implementar preco promocional
    return total;
  }

  DateTime get dueDate {
    final now = DateTime.now();
    return DateTime(now.year, now.month, billingDay, now.hour, now.minute, now.second, now.millisecond, now.microsecond);
  }
}
