import 'dart:convert';

class EventSendData {
  final String id;

  final Map data;
  EventSendData({
    required this.id,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': data,
    };
  }

  factory EventSendData.fromMap(Map<String, dynamic> map) {
    return EventSendData(
      id: map['id'] ?? '',
      data: Map.from(map['data'] ?? const {}),
    );
  }

  String toJson() => json.encode(toMap());

  String buildData() => json.encode(data);

  factory EventSendData.fromJson(String source) => EventSendData.fromMap(json.decode(source));
}
