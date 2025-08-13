import 'dart:convert';
import 'package:core/core.dart';
import 'package:core/src/exceptions/serialization_exception.dart';

class FranchiseEntity {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double profitPercent;
  final String userId;
  final AppLocaleCode locale;
  final String displayName;
  final String? paymentProviderId;
  FranchiseEntity({
    required this.id,
    this.createdAt,
    this.updatedAt,
    required this.profitPercent,
    required this.userId,
    required this.locale,
    required this.displayName,
    required this.paymentProviderId,
  });
  static const String table = 'franchisees';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt?.toPaipDB(),
      'updated_at': updatedAt?.toPaipDB(),
      'profitPercent': profitPercent,
      'userId': userId,
      'locale': locale.name,
      'displayName': displayName,
      'payment_provider_id': paymentProviderId,
    };
  }

  factory FranchiseEntity.fromMap(
    Map<String, dynamic> map,
  ) {
    try {
      return FranchiseEntity(
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
        profitPercent: map['profitPercent']?.toDouble() ?? 0.0,
        userId: map['userId'] ?? '',
        locale: AppLocaleCode.fromMap(
          map['locale'],
        ),
        displayName: map['displayName'] ?? '',
        paymentProviderId: map['payment_provider_id'],
      );
    } catch (e) {
      throw SerializationException(map: map, runTimeType: 'FranchiseEntity', stackTrace: StackTrace.current);
    }
  }

  String toJson() => json.encode(
        toMap(),
      );

  factory FranchiseEntity.fromJson(
    String source,
  ) =>
      FranchiseEntity.fromMap(
        json.decode(
          source,
        ),
      );
}
