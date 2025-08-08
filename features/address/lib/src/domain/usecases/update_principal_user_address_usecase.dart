import 'package:auth/auth.dart';
import 'package:core/core.dart';

class UpdateUserPrincipalAddressUsecase {
  final IAuthApi authApi;
  UpdateUserPrincipalAddressUsecase({required this.authApi});

  Future<void> call(String addressID) async {
    if (UserMe.me == null) throw Exception('User not found');
    final meWithNewAddress = UserMe.me!.copyWith(metadata: UserMe.me!.metadata.copyWith(selectedAddressId: addressID));
    await authApi.updateMe(me: meWithNewAddress);
  }
}
