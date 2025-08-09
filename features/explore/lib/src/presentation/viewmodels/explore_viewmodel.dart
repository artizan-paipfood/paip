import 'package:auth/auth.dart';
import 'package:core/core.dart';

class ExploreViewmodel {
  AddressEntity? get selectedAddress => UserMe.me?.addresses.firstWhereOrNull(
        (a) => a.id == UserMe.me?.data.selectedAddressId,
      );
}
