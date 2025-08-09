import 'dart:math';
import 'package:paipfood_package/paipfood_package.dart';

class CalculateAnglePolygonUsecase {
  double call(LatLongModel center, LatLongModel point) {
    final latDiff = point.latLng.latitude - center.latLng.latitude;
    final lngDiff = point.latLng.longitude - center.latLng.longitude;
    final angle = (180.0 / pi) * atan2(latDiff, lngDiff);
    return angle >= 0 ? angle : angle + 360.0;
  }
}
