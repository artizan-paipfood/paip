import 'package:app/src/modules/user/domain/usecases/user_usecase.dart';
import 'package:app/src/modules/user/domain/dtos/user_dto.dart';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AddressUserUsecase {
  final IAddressApi addressApi;
  final AddressRepository addressRepo;
  final AuthRepository authRepo;

  final UserUsecase userUsecase;

  AddressUserUsecase({required this.addressApi, required this.addressRepo, required this.authRepo, required this.userUsecase});
  AddressEntity? get currentAddress => AuthNotifier.instance.auth.user?.getAddress;

  Future<List<AddressModel>> autoComplete({required String query}) async {
    return await addressApi.autocomplete(request: AutoCompleteRequest(query: query, locale: LocaleNotifier.instance.locale, provider: AutoCompleteProvider.mapbox));
  }

  Future<AddressEntity> searchByPostalCode({required UserDto userVm, required String value}) async {
    final result = await addressApi.postalcodeGeocode(request: PostcodeGeocodeRequest(postalCode: value, provider: AutoCompleteProvider.mapbox, locale: LocaleNotifier.instance.locale));
    return AddressEntity.fromAddressModel(result).copyWith(
      number: userVm.address?.number,
      complement: userVm.address?.complement,
      street: result.street?.isEmpty ?? true ? userVm.address?.street : result.street,
    );
  }

  Future<AddressEntity> saveNewAddress({required AddressEntity address}) async {
    address = address.copyWith(userId: AuthNotifier.instance.auth.user!.id);

    final result = await addressRepo.upsert(address: address, auth: AuthNotifier.instance.auth);

    AuthNotifier.instance.update(
      AuthNotifier.instance.auth.copyWith(
        user: AuthNotifier.instance.auth.user!.copyWith(
          currentAddressId: result.id,
          addresses: [...AuthNotifier.instance.auth.user!.addresses, result],
        ),
      ),
    );

    await userUsecase.update(UserDto.fromAuth());
    return result;
  }

  Future<void> updatePrincipalAddress(String addressId) async {
    AuthNotifier.instance.update(
      AuthNotifier.instance.auth.copyWith(
        user: AuthNotifier.instance.auth.user!.copyWith(
          currentAddressId: addressId,
        ),
      ),
    );
    await authRepo.updateUser(auth: AuthNotifier.instance.auth);
  }

  Future<List<AddressEntity>> getAll(String userId) async {
    return await addressRepo.getByUserId(userId);
  }

  Future<void> deleteAddress(AddressEntity address) async {
    await addressRepo.deleteById(address.id);

    final updatedAddresses = List<AddressEntity>.from(AuthNotifier.instance.auth.user!.addresses);
    updatedAddresses.remove(address);

    String? newCurrentAddressId = AuthNotifier.instance.auth.user!.currentAddressId;
    if (newCurrentAddressId == address.id) {
      newCurrentAddressId = null;
    }

    AuthNotifier.instance.update(
      AuthNotifier.instance.auth.copyWith(
        user: AuthNotifier.instance.auth.user!.copyWith(
          currentAddressId: newCurrentAddressId,
          addresses: updatedAddresses,
        ),
      ),
    );

    await authRepo.updateUser(auth: AuthNotifier.instance.auth);
  }
}
