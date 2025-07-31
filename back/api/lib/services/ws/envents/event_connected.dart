import 'dart:convert';

class EventConnected {
  final String hash;
  EventConnected({
    required this.hash,
  });

  Map<String, dynamic> toMap() {
    return {
      'event_status': 'connected',
      'hash': hash,
    };
  }

  factory EventConnected.fromMap(Map<String, dynamic> map) {
    return EventConnected(
      hash: map['hash'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EventConnected.fromJson(String source) => EventConnected.fromMap(json.decode(source));
}
