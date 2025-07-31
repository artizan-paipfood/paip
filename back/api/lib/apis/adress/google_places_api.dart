import 'package:api/constants/base_url.dart';
import 'package:api/repositories/address/responses/google_autocomplete_response.dart';
import 'package:api/services/process_env.dart';
import 'package:api/services/utils.dart';
import 'package:core/core.dart';

class GooglePlacesApi {
  final IClient client;
  GooglePlacesApi({required this.client});

  Future<AddressModel> geocode({required String query, required DbLocale locale, required AddressModel address, double? lat, double? lon, int? radius}) async {
    final String _bounds = (radius != null && lat != null && lon != null) ? '&bounds=${BackUtils.calculateBoundingBox(latitude: lat, longitude: lon, radiusInKm: radius).bounds}' : '';
    final request = await client.get('${BaseUrl.googleGeocode}/json?key=${ProcessEnv.googleMapsApikey}&components=country:${locale.name.toUpperCase()}$_bounds&address=$query');

    final List list = List.from(request.data['results']);
    final geocode = GoogleGeocodeResponse.fromMap(list.first as Map<String, dynamic>);
    return AddressModel.fromGoogleMaps(address: address, geocode: geocode);
  }

  Future<List<AddressModel>> autoComplete({required String query, required DbLocale locale, String? sessionToken, double? lat, double? lon, int? radius}) async {
    final String location = (radius != null && lat != null && lon != null) ? '&location=$lat,$lon&radius=$radius' : '';
    final request = await client.get('${BaseUrl.googleAutocomplete}/json?input=$query&types=geocode&key=${ProcessEnv.googleMapsApikey}&components=country:${locale.name.toUpperCase()}$location');

    final List predictions = request.data['predictions'];
    final suggestions = predictions.map((e) => GoogleAutoCompleteResponse.fromMap(e as Map<String, dynamic>)).toList();
    return suggestions.map((e) => AddressModel.fromGoogleMaps(address: AddressModel(mainText: e.mainText, secondaryText: e.secondaryText, formattedAddress: "${e.mainText}, ${e.secondaryText}", placeId: e.placeId))).toList();
  }
}
