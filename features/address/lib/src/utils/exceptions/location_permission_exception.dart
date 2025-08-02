import 'package:core/core.dart';

enum LocationPermissionExceptionType {
  disabled,
  denied,
  deniedForever;
}

class LocationPermissionException extends GenericException {
  final LocationPermissionExceptionType type;
  LocationPermissionException(super.message, this.type);
}
