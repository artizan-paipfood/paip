export 'event_connected.dart';
export 'event_initialize.dart';
export 'event_send_data.dart';

enum EventStatus {
  connected,
  initialize,
  send_data,
  response,
  close;

  static EventStatus fromMap(String value) => EventStatus.values.firstWhere((e) => e.name == value);
}
