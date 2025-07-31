import 'package:api/services/process_env.dart';
import 'package:core/core.dart';

class RadarApi {
  final IClient client;

  RadarApi({required this.client});

  Future<List<AddressModel>> autoComplete({required String query, required DbLocale locale, String? sessionToken, double? lat, double? lon, int? radius}) async {
    final near = (lat != null && lon != null) ? '&near=$lat,$lon' : '';
    final response = await client.get('https://api.radar.io/v1/search/autocomplete?query=$query&limit=5$near', headers: {'Authorization': '${ProcessEnv.radarSecretKey}'});
    final List list = response.data['addresses'];
    return list.map((e) => AddressModel.fromRadar(e)).toList();
  }
}
