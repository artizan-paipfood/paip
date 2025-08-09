import 'package:core/core.dart';

class SelectAddressEvent {
  final AddressEntity address;
  SelectAddressEvent({required this.address});
}

class MyPositionAddressEvent {
  final AddressEntity address;
  MyPositionAddressEvent({required this.address});
}
