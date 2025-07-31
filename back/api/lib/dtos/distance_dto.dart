import 'dart:convert';

class DistanceDto {
  final double distance;
  final double straightDistance;
  DistanceDto({
    required this.distance,
    required this.straightDistance,
  });

  DistanceDto copyWith({
    double? distance,
    double? straightDistance,
  }) {
    return DistanceDto(
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

  factory DistanceDto.fromMap(Map<String, dynamic> map) {
    return DistanceDto(
      distance: map['distance']?.toDouble() ?? 0.0,
      straightDistance: map['straight_distance']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DistanceDto.fromJson(String source) => DistanceDto.fromMap(json.decode(source));
}
