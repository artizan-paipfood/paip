import 'dart:convert';

class CacheDto {
  final Map data;
  final DateTime? expiresIn;
  CacheDto({
    required this.data,
    this.expiresIn,
  });
  bool get isExpired => expiresIn != null && expiresIn!.isBefore(DateTime.now());

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'expires_in': expiresIn?.millisecondsSinceEpoch,
    };
  }

  factory CacheDto.fromMap(Map map) {
    return CacheDto(
      data: Map.from(map['data']),
      expiresIn: map['expires_in'] != null ? DateTime.fromMillisecondsSinceEpoch(map['expires_in']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CacheDto.fromJson(String source) => CacheDto.fromMap(json.decode(source));
}
