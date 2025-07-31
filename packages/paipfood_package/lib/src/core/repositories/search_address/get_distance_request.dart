import 'dart:convert';

class GetDistanceRequest {
  final double originlat;
  final double originlong;
  final double destlat;
  final double destlong;
  final String? userAddressId;
  final String? establishmentAddressId;
  GetDistanceRequest({
    required this.originlat,
    required this.originlong,
    required this.destlat,
    required this.destlong,
    this.userAddressId,
    this.establishmentAddressId,
  });

  GetDistanceRequest copyWith({
    double? originlat,
    double? originlong,
    double? destlat,
    double? destlong,
    String? userAddressId,
    String? establishmentAddressId,
  }) {
    return GetDistanceRequest(
      originlat: originlat ?? this.originlat,
      originlong: originlong ?? this.originlong,
      destlat: destlat ?? this.destlat,
      destlong: destlong ?? this.destlong,
      userAddressId: userAddressId ?? this.userAddressId,
      establishmentAddressId: establishmentAddressId ?? this.establishmentAddressId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'originlat': originlat,
      'originlong': originlong,
      'destlat': destlat,
      'destlong': destlong,
      'user_address_id': userAddressId,
      'establishment_address_id': establishmentAddressId,
    };
  }

  factory GetDistanceRequest.fromMap(Map<String, dynamic> map) {
    return GetDistanceRequest(
      originlat: map['originlat']?.toDouble() ?? 0.0,
      originlong: map['originlong']?.toDouble() ?? 0.0,
      destlat: map['destlat']?.toDouble() ?? 0.0,
      destlong: map['destlong']?.toDouble() ?? 0.0,
      userAddressId: map['user_address_id'],
      establishmentAddressId: map['establishment_address_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GetDistanceRequest.fromJson(String source) => GetDistanceRequest.fromMap(json.decode(source));
}
