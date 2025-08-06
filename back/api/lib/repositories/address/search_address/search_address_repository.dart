import 'package:api/apis/adress/cep_awesome_api.dart';
import 'package:api/apis/adress/postcodes_api.dart';
import 'package:api/apis/adress/radar_api.dart';
import 'package:core/core.dart';

abstract class ISearchAddressRepository {
  Future<AddressModel> geocode({required String query, required AppLocaleCode locale, required AddressModel address, required int radius, double? lat, double? lon});

  Future<List<AddressModel>> autoComplete({required String query, required AppLocaleCode locale, required int radius, String? sessionToken, double? lat, double? lon});

  Future<AddressModel> searchByPostalcode({required String postalCode, required AppLocaleCode locale, required int radius, String? sessionToken, double? lat, double? lon});
}

class BrSearchAddressRepository extends ISearchAddressRepository {
  final CepAwesomeApi cepAwesomeApi;
  final RadarApi radarApi;
  BrSearchAddressRepository({
    required this.cepAwesomeApi,
    required this.radarApi,
  });

  @override
  Future<List<AddressModel>> autoComplete({required String query, required AppLocaleCode locale, required int radius, String? sessionToken, double? lat, double? lon}) async {
    return await radarApi.autoComplete(
      query: query,
      locale: locale,
      sessionToken: sessionToken,
      lat: lat,
      lon: lon,
      radius: radius,
    );
  }

  @override
  Future<AddressModel> geocode({required String query, required AppLocaleCode locale, required AddressModel address, required int radius, double? lat, double? lon}) {
    throw UnimplementedError();
  }

  @override
  Future<AddressModel> searchByPostalcode({required String postalCode, required AppLocaleCode locale, required int radius, String? sessionToken, double? lat, double? lon}) async {
    final cep = await cepAwesomeApi.getAddressByCep(cep: postalCode);
    final List<AddressModel> result = await radarApi.autoComplete(
      query: cep.mainText,
      locale: locale,
      sessionToken: sessionToken,
      lat: lat,
      lon: lon,
      radius: radius,
    );
    return result.firstWhere((r) => (r.street?.contains(cep.street ?? '') ?? false) && (r.city?.contains(cep.city ?? '') ?? false), orElse: () => result.first);
  }
}

class GbSearchAddressRepository extends ISearchAddressRepository {
  final PostCodesApi postCodesApi;
  final RadarApi radarApi;
  GbSearchAddressRepository({required this.postCodesApi, required this.radarApi});

  @override
  Future<List<AddressModel>> autoComplete({required String query, required AppLocaleCode locale, required int radius, String? sessionToken, double? lat, double? lon}) async {
    return await radarApi.autoComplete(
      query: query,
      locale: locale,
      sessionToken: sessionToken,
      lat: lat,
      lon: lon,
      radius: radius,
    );
  }

  @override
  Future<AddressModel> geocode({required String query, required AppLocaleCode locale, required AddressModel address, required int radius, double? lat, double? lon}) {
    throw UnimplementedError();
  }

  @override
  Future<AddressModel> searchByPostalcode({required String postalCode, required AppLocaleCode locale, required int radius, String? sessionToken, double? lat, double? lon}) async {
    return await postCodesApi.getAddressByPostalCode(postalCode: postalCode);
  }
}
