import 'dart:convert';

class DriverEstablishmentModel {
  final DateTime createdAt;
  final String establishmentId;
  final String driverId;
  final bool isAccepted;

  DriverEstablishmentModel({
    required this.createdAt,
    required this.establishmentId,
    required this.driverId,
    this.isAccepted = false,
  });
  static String get box => "driver_establishments";
  Map<String, dynamic> toMap() {
    return {
      'establishment_id': establishmentId,
      'driver_id': driverId,
      'is_accepted': isAccepted,
    };
  }

  factory DriverEstablishmentModel.fromMap(Map<String, dynamic> map) {
    return DriverEstablishmentModel(
      createdAt: DateTime.parse(map['created_at']),
      establishmentId: map['establishment_id'],
      driverId: map['driver_id'],
      isAccepted: map['is_accepted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverEstablishmentModel.fromJson(String source) => DriverEstablishmentModel.fromMap(json.decode(source));
}
