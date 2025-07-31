import 'package:core/core.dart';

class Helper {
  Helper._();
  static double calculateDeliveryTax({
    required DbLocale locale,
    DeliveryAreaPerMileEntity? deliveryAreaPerMile,
    double? distance,
    double? straightDistance,
    double? price,
    double roundTo = 0.5,
  }) {
    if (price != null) return price;
    if (deliveryAreaPerMile == null) throw const FormatException("DeliveryAreaPerMileEntity is null");
    final isGb = locale == DbLocale.gb;
    final pricePerMile = deliveryAreaPerMile.pricePerMile;
    final minPrice = deliveryAreaPerMile.minPrice;
    final distanceInPreferredUnit = isGb ? (straightDistance ?? 0.0) / 1609.34 : (distance ?? 0.0) / 1000;
    final minDistance = isGb ? deliveryAreaPerMile.minDistance / 1609.34 : deliveryAreaPerMile.minDistance / 1000;

    if (distanceInPreferredUnit < minDistance) return 0;

    final calculatedPrice = distanceInPreferredUnit * pricePerMile;

    final result = calculatedPrice < minPrice ? minPrice : calculatedPrice;
    return (result / roundTo).ceil() * roundTo;
  }
}
