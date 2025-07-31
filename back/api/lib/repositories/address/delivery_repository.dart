import 'package:api/apis/adress/geoapify_api.dart';
import 'package:api/dtos/distance_dto.dart';
import 'package:core/core.dart';
import 'package:api/constants/base_url.dart';
import 'package:api/services/process_env.dart';

abstract interface class IDeliveryRepository {
  Future<DistanceDto> getDistance({required double originlat, required double originlong, required double destlat, required double destlong});

  Future<DeliveryAreaEntity?> getDeliveryAreaByLatLong({required String establishmentId, required double lat, required double long});

  Future<double> getTaxByDistance({required String establishmentId, required double distanceRadius});
}

class AddressRepository implements IDeliveryRepository {
  final IClient client;
  final GeoApifyApi geoApifyApi;
  AddressRepository({required this.client, required this.geoApifyApi});

  @override
  Future<DistanceDto> getDistance({required double originlat, required double originlong, required double destlat, required double destlong}) async {
    return await geoApifyApi.getDistance(
      originlat: originlat,
      originlong: originlong,
      destlat: destlat,
      destlong: destlong,
    );
  }

  @override
  Future<DeliveryAreaEntity?> getDeliveryAreaByLatLong({required String establishmentId, required double lat, required double long}) async {
    final response = await client.post(
      "${BaseUrl.supabase}/rest/v1/rpc/func_get_deliveryarea_by_polygon",
      headers: {
        "Prefer": ["resolution=merge-duplicates", "return=representation"],
        "apikey": ProcessEnv.supabaseApikey,
      },
      data: {"p_establishment_id": establishmentId, "p_lat": lat, "p_long": long},
    );
    final List list = response.data;
    if (list.isEmpty) return null;

    return DeliveryAreaEntity.fromMap(list.first);
  }

  @override
  Future<double> getTaxByDistance({required String establishmentId, required double distanceRadius}) async {
    try {
      final response = await client.post(
        "${BaseUrl.supabase}/rest/v1/rpc/func_get_delivery_tax_by_distance",
        headers: {
          // "Prefer": ["resolution=merge-duplicates", "return=representation"],
          "apikey": ProcessEnv.supabaseApikey,
        },
        data: {"p_establishment_id": establishmentId, "p_distance_radius": distanceRadius},
      );
      return response.data.toDouble();
    } on ClientException catch (e) {
      if (e.message != null && e.message!.contains('not allowed')) {
        throw GenericException('Distance not allowed for this establishment');
      }
      rethrow;
    }
  }
}
