import 'package:core/core.dart';

abstract class RouteEvent {}

class GoAutoCompleteEvent extends RouteEvent {}

class GoPostcodeEvent extends RouteEvent {}

class GoMyAddressesEvent {
  final bool go;
  GoMyAddressesEvent({required this.go});
}

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

class GoEditAddressEvent extends RouteEvent {
  final AddressEntity address;

  GoEditAddressEvent({required this.address});
}
