import 'package:manager/src/modules/delivery/aplication/usecases/calculate_angle_plygon_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class OrderPolyginPointsUsecase {
  Future<List<LatLongModel>> call({required List<LatLongModel> latLongs, required String establishmentId}) async {
    final calculateAnglePolygonUsecase = CalculateAnglePolygonUsecase();
    // Esse cara encontra o ponto central do polígono
    double sumLat = 0;
    double sumLng = 0;
    for (final latLong in latLongs) {
      sumLat += latLong.latLng.latitude;
      sumLng += latLong.latLng.longitude;
    }
    final centerLat = sumLat / latLongs.length;
    final centerLng = sumLng / latLongs.length;
    if (latLongs.isEmpty) {
      return [];
    }
    final center = LatLongModel(deliveryAreaId: latLongs.first.deliveryAreaId, id: uuid, latLng: LatLng(centerLat, centerLng), establishmentId: establishmentId);

    // Esse cara ordena os pontos pelo ângulo que eles formam em relação ao ponto central
    latLongs.sort((a, b) {
      final angleA = calculateAnglePolygonUsecase(center, a);
      final angleB = calculateAnglePolygonUsecase(center, b);
      return angleA.compareTo(angleB);
    });

    return latLongs;
  }
}
