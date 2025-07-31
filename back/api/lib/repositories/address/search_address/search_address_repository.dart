import 'package:api/apis/adress/cep_awesome_api.dart';
import 'package:api/apis/adress/google_places_api.dart';
import 'package:api/apis/adress/postcodes_api.dart';
import 'package:api/apis/adress/radar_api.dart';
import 'package:core/core.dart';

abstract class ISearchAddressRepository {
  Future<AddressModel> geocode({required String query, required DbLocale locale, required AddressModel address, double? lat, double? lon, int? radius});

  Future<List<AddressModel>> autoComplete({required String query, required DbLocale locale, String? sessionToken, double? lat, double? lon, int? radius});

  Future<AddressModel> searchByPostalcode({required String postalCode, required DbLocale locale, String? sessionToken, double? lat, double? lon, int? radius});
}

class BrSearchAddressRepository extends ISearchAddressRepository {
  final CepAwesomeApi cepAwesomeApi;
  final RadarApi radarApi;
  BrSearchAddressRepository({
    required this.cepAwesomeApi,
    required this.radarApi,
  });

  @override
  Future<List<AddressModel>> autoComplete({required String query, required DbLocale locale, String? sessionToken, double? lat, double? lon, int? radius}) async {
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
  Future<AddressModel> geocode({required String query, required DbLocale locale, required AddressModel address, double? lat, double? lon, int? radius}) {
    throw UnimplementedError();
  }

  @override
  Future<AddressModel> searchByPostalcode({required String postalCode, required DbLocale locale, String? sessionToken, double? lat, double? lon, int? radius}) async {
    return await cepAwesomeApi.getAddressByCep(cep: postalCode);
  }
}

class GbSearchAddressRepository extends ISearchAddressRepository {
  final PostCodesApi postCodesApi;
  final GooglePlacesApi googlePlacesApi;
  GbSearchAddressRepository({required this.postCodesApi, required this.googlePlacesApi});

  @override
  Future<List<AddressModel>> autoComplete({required String query, required DbLocale locale, String? sessionToken, double? lat, double? lon, int? radius}) async {
    return await googlePlacesApi.autoComplete(
      query: query,
      locale: locale,
      sessionToken: sessionToken,
      lat: lat,
      lon: lon,
      radius: radius,
    );
  }

  @override
  Future<AddressModel> geocode({required String query, required DbLocale locale, required AddressModel address, double? lat, double? lon, int? radius}) {
    return googlePlacesApi.geocode(query: query, locale: locale, address: address, lat: lat, lon: lon, radius: radius);
  }

  @override
  Future<AddressModel> searchByPostalcode({required String postalCode, required DbLocale locale, String? sessionToken, double? lat, double? lon, int? radius}) async {
    return await postCodesApi.getAddressByPostalCode(postalCode: postalCode);
  }
}
