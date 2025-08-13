import 'package:core/core.dart';

abstract interface class IEstablishmentApi {
  Future<List<EstablishmentExplore>> getEstablishmentByLocation({required double lat, required double long, required double radiusKm});
}

class EstablishmentApi implements IEstablishmentApi {
  final IClient client;
  EstablishmentApi({
    required this.client,
  });
  @override
  Future<List<EstablishmentExplore>> getEstablishmentByLocation({required double lat, required double long, required double radiusKm}) async {
    final response = await client.post('/rest/v1/rpc/func_get_establishments_by_location', data: {
      "p_lat": lat,
      "p_long": long,
      "p_radius_km": radiusKm,
    });
    final List list = List.from(response.data);
    return list.map((e) => EstablishmentExplore.fromMap(e)).toList();
  }
}
