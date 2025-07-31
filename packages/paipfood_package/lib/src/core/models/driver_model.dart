import 'dart:convert';

class DriverModel {
  final DateTime createdAt;
  final String userId;
  final bool isAvaliable;
  final double lat;
  final double long;
  final String endPhone;
  const DriverModel({
    required this.createdAt,
    this.userId = '',
    this.isAvaliable = false,
    this.lat = 0.0,
    this.long = 0.0,
    this.endPhone = '',
  });
  String get box => "drivers";
  DriverModel copyWith({
    DateTime? createdAt,
    String? userId,
    bool? isAvaliable,
    double? lat,
    double? long,
    String? endPhone,
  }) {
    return DriverModel(
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      isAvaliable: isAvaliable ?? this.isAvaliable,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      endPhone: endPhone ?? this.endPhone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'is_avaliable': isAvaliable,
      'lat': lat,
      'long': long,
      'end_phone': endPhone.substring(endPhone.length - 4),
    };
  }

  factory DriverModel.fromMap(Map map) {
    return DriverModel(
      createdAt: DateTime.parse(map['created_at']),
      userId: map['user_id'] ?? '',
      isAvaliable: map['is_avaliable'] ?? false,
      lat: map['lat']?.toDouble() ?? 0.0,
      long: map['long']?.toDouble() ?? 0.0,
      endPhone: map['end_phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverModel.fromJson(String source) => DriverModel.fromMap(json.decode(source));
}
