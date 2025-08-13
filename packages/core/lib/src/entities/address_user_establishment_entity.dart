import 'dart:convert';

import 'package:core/src/exceptions/serialization_exception.dart';

class AddressUserEstablishmentEntity {
  final String userAddressId;
  final String establishmentAddressId;
  final double distance;
  final double straightDistance;

  AddressUserEstablishmentEntity({
    required this.userAddressId,
    required this.establishmentAddressId,
    required this.distance,
    required this.straightDistance,
  });
  static const String table = 'address_user_establishment';

  Map<String, dynamic> toMap() {
    return {
      'user_address_id': userAddressId,
      'establishment_address_id': establishmentAddressId,
      'distance': distance,
      'straight_distance': straightDistance,
    };
  }

  factory AddressUserEstablishmentEntity.fromMap(Map<String, dynamic> map) {
    try {
      return AddressUserEstablishmentEntity(
        userAddressId: map['user_address_id'],
        establishmentAddressId: map['establishment_address_id'],
        distance: map['distance']?.toDouble(),
        straightDistance: map['straight_distance']?.toDouble(),
      );
    } catch (e) {
      throw SerializationException(map: map, runTimeType: 'AddressUserEstablishmentEntity', stackTrace: StackTrace.current);
    }
  }

  String toJson() => json.encode(toMap());

  factory AddressUserEstablishmentEntity.fromJson(String source) => AddressUserEstablishmentEntity.fromMap(json.decode(source));

  AddressUserEstablishmentEntity copyWith({
    String? userAddressId,
    String? establishmentAddressId,
    double? distance,
    double? straightDistance,
  }) {
    return AddressUserEstablishmentEntity(
      userAddressId: userAddressId ?? this.userAddressId,
      establishmentAddressId: establishmentAddressId ?? this.establishmentAddressId,
      distance: distance ?? this.distance,
      straightDistance: straightDistance ?? this.straightDistance,
    );
  }
}
