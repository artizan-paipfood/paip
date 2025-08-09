import 'dart:convert';
import 'package:core/core.dart';

enum Plans {
  standard,
  pro,
  plus;

  static Plans fromMap(String value) => Plans.values.firstWhere((element) => element.name == value);
}

class PlansModel {
  final String id;
  final DateTime createdAt;
  final double price;
  final double? promotionalPrice;
  final int? promotionDurationInDays;
  final AppLocaleCode locale;
  final bool enable;
  final Plans plan;
  final int? usageLimit;
  PlansModel({
    required this.createdAt,
    required this.locale,
    required this.plan,
    required this.price,
    required this.id,
    this.promotionalPrice,
    this.promotionDurationInDays,
    this.usageLimit,
    this.enable = false,
  });

  static const String box = "plans";

  PlansModel copyWith({
    String? id,
    DateTime? createdAt,
    double? price,
    double? promotionalPrice,
    int? promotionDurationInDays,
    AppLocaleCode? locale,
    bool? enable,
    Plans? plan,
    int? usageLimit,
  }) {
    return PlansModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      price: price ?? this.price,
      promotionalPrice: promotionalPrice ?? this.promotionalPrice,
      promotionDurationInDays: promotionDurationInDays ?? this.promotionDurationInDays,
      locale: locale ?? this.locale,
      enable: enable ?? this.enable,
      plan: plan ?? this.plan,
      usageLimit: usageLimit ?? this.usageLimit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.millisecondsSinceEpoch,
      'price': price,
      'promotional_price': promotionalPrice,
      'promotion_duration_in_days': promotionDurationInDays,
      'locale': locale.name,
      'enable': enable,
      'plan': plan.name,
      'usageLimit': usageLimit,
    };
  }

  factory PlansModel.fromMap(Map<String, dynamic> map) {
    return PlansModel(
      id: map['id'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
      price: map['price']?.toDouble() ?? 0.0,
      promotionalPrice: map['promotional_price']?.toDouble(),
      promotionDurationInDays: map['promotion_duration_in_days']?.toInt(),
      locale: map['locale'] != null ? AppLocaleCode.fromMap(map['locale']) : AppLocaleCode.br,
      enable: map['enable'] ?? false,
      plan: Plans.fromMap(map['plan']),
      usageLimit: map['usage_limit']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlansModel.fromJson(String source) => PlansModel.fromMap(json.decode(source));
}
