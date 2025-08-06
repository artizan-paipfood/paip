import 'package:api/constants/base_url.dart';
import 'package:api/dtos/distance_dto.dart';

import 'package:api/services/process_env.dart';
import 'package:api/services/utils.dart';
import 'package:core/core.dart';

class GeoApifyApi {
  final IClient client;
  GeoApifyApi({required this.client});
  static String _baseUrl = BaseUrl.mapbox;

  Future<List<AddressModel>> autoComplete({required String query, required AppLocaleCode locale, String? sessionToken, double? lat, double? lon, int? radius}) async {
    final Map<String, dynamic> params = {
      "q": query,
      "session_token": sessionToken!,
      "country": locale.name.toLowerCase(),
      "access_token": ProcessEnv.mapboxAccessToken,
    };
    if (radius != null && lat != null && lon != null) {
      final bounding = BackUtils.calculateBoundingBox(latitude: lat, longitude: lon, radiusInKm: radius);
      params["bbox"] = "${bounding.lonMin},${bounding.latMin},${bounding.lonMax},${bounding.latMax}";
    }
    final request = await client.get('$_baseUrl/search/searchbox/v1/suggest', query: params);
    final List list = request.data['suggestions'];
    final List<MapboxAutoCompleteResponse> autocompletes = list.map((e) => MapboxAutoCompleteResponse.fromMap(e)).toList();
    return autocompletes.map((e) => AddressModel.fromMapBox(autocomplete: e)).toList();
  }

  Future<DistanceDto> getDistance({required double originlat, required double originlong, required double destlat, required double destlong}) async {
    final request = await client.get('${BaseUrl.geoapify}/v1/routing?waypoints=$originlat,$originlong|$destlat,$destlong&mode=motorcycle&type=short&units=metric&apiKey=${ProcessEnv.geoapifyApikey}');
    final data = request.data;
    final meters = data['features'][0]['properties']['distance'];
    final distance = _parseDistance(meters);
    final straightDistance = BackUtils.calculateStraightDistance(lat1: originlat, lon1: originlong, lat2: destlat, lon2: destlong);
    return DistanceDto(distance: distance, straightDistance: straightDistance.toDouble());
  }

  double _parseDistance(double distance) {
    int percent = distance.toInt();

    if (percent < 5) percent = 5;

    if (percent > 10) percent = 10;

    return distance - (distance * (percent / 100));
  }
}
