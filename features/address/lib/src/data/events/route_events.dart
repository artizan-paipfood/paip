abstract class RouteEvent {}

class GoAutoCompleteEvent extends RouteEvent {}

class GoPostcodeEvent extends RouteEvent {}

class GoMyAddressesEvent extends RouteEvent {}

class GoMyPositionEvent extends RouteEvent {
  final double lat;
  final double lng;

  GoMyPositionEvent({required this.lat, required this.lng});
}

class GoManuallyEvent extends RouteEvent {
  final double lat;
  final double lng;

  GoManuallyEvent({required this.lat, required this.lng});
}
