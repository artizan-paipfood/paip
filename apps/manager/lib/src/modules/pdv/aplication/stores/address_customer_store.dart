import 'package:manager/src/core/datasources/data_source.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AddressCustomerStore {
  final IAddressApi addressApi;
  final DataSource dataSource;
  AddressCustomerStore({
    required this.addressApi,
    required this.dataSource,
  });

  AddressEntity address = AddressEntity(id: uuid);

  Future<AddressEntity> getAddress() async {
    if (address.lat == 0 && address.long == 0) {
      final number = address.number;
      final street = address.street;
      final complement = address.complement;
      final neighborhood = address.neighborhood;
      final result = await addressApi
          .autocomplete(
            request: AutoCompleteRequest(
              query: '${address.street} ${address.number}',
              locale: LocaleNotifier.instance.locale,
              provider: AutoCompleteProvider.mapbox,
              lat: establishmentProvider.value.address!.lat,
              lon: establishmentProvider.value.address!.long,
            ),
          )
          .then((value) => value.first);
      final geocode = await addressApi.geocode(
        request: GeocodeRequest(
          query: result.formattedAddress,
          provider: AutoCompleteProvider.mapbox,
          locale: LocaleNotifier.instance.locale,
          address: result,
        ),
      );

      address = AddressEntity.fromAddressModel(geocode).copyWith(number: number, complement: complement, street: street, neighborhood: neighborhood);
    }
    return address;
  }

  Future<void> setAddress(AddressEntity value) async {
    final number = address.number;
    final complement = address.complement;
    final neighborhood = address.neighborhood;
    address = value.copyWith(number: number, complement: complement, neighborhood: neighborhood);
  }

  Future<void> searchByZipcode(String value) async {
    final street = address.street;
    final number = address.number;
    final complement = address.complement;
    final result = await addressApi.postalcodeGeocode(
        request: PostalcodeGeocodeRequest(
      postalCode: value,
      provider: AutoCompleteProvider.mapbox,
      locale: LocaleNotifier.instance.locale,
    ));

    address = AddressEntity.fromAddressModel(result).copyWith(
      number: number,
      complement: complement,
      street: result.street?.isEmpty ?? true ? street : result.street,
    );
  }
}
