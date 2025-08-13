import 'dart:math';

import 'package:api/domain/dtos/bounding.dart';

class BackUtils {
  BackUtils._();

  static int calculateStraightDistance({required double lat1, required double lon1, required double lat2, required double lon2}) {
    const double earthRadiusMeters = 6371000.0; // Raio da Terra em metros

    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLon = _degreesToRadians(lon2 - lon1);

    final double a = sin(dLat / 2) * sin(dLat / 2) + cos(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final double distance = earthRadiusMeters * c;

    return distance.round(); // Retorna arredondado para o inteiro mais próximo
  }

  static double _degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  static String? getPathParam({required String url, required String param}) {
    final Uri uri = Uri.parse(url);
    return uri.queryParameters[param];
  }

  static Bounding calculateBoundingBox({
    required double latitude,
    required double longitude,
    required int radiusInKm,
  }) {
    final double latDelta = radiusInKm / 111.0; // 1 grau de latitude = ~111km
    final double lonDelta = radiusInKm / (111.0 * cos(latitude * pi / 180));

    return Bounding(latMin: latitude - latDelta, latMax: latitude + latDelta, lonMin: longitude - lonDelta, lonMax: longitude + lonDelta);
  }
}
