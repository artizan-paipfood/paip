import 'dart:convert';

class GetDistanceResponse {
  final double distance;
  final double straightDistance;

  GetDistanceResponse({required this.distance, required this.straightDistance});

  GetDistanceResponse copyWith({
    double? distance,
    double? straightDistance,
  }) {
    return GetDistanceResponse(
      distance: distance ?? this.distance,
      straightDistance: straightDistance ?? this.straightDistance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'distance': distance,
      'straight_distance': straightDistance,
    };
  }

  factory GetDistanceResponse.fromMap(Map<String, dynamic> map) {
    return GetDistanceResponse(
      distance: map['distance']?.toDouble() ?? 0.0,
      straightDistance: map['straight_distance']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetDistanceResponse.fromJson(String source) => GetDistanceResponse.fromMap(json.decode(source));
}
