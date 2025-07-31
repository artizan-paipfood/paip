import 'dart:convert';

class EventInitialize {
  final String id;
  final String hash;
  EventInitialize({
    required this.id,
    required this.hash,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hash': hash,
    };
  }

  factory EventInitialize.fromMap(Map<String, dynamic> map) {
    return EventInitialize(
      id: map['id'] ?? '',
      hash: map['hash'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EventInitialize.fromJson(String source) => EventInitialize.fromMap(json.decode(source));
}
