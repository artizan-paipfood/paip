import 'package:core/core.dart';

class DeliveryTaxRequest {
  final double lat;
  final double long;
  final double establishmentLat;
  final double establishmentLong;
  final DeliveryMethod deliveryMethod;
  final String establishmentId;
  final String? userAddressId;
  final String? establishmentAddressId;

  DeliveryTaxRequest({required this.lat, required this.long, required this.establishmentLat, required this.establishmentLong, required this.deliveryMethod, required this.establishmentId, required this.userAddressId, required this.establishmentAddressId});

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'long': long,
      'establishment_lat': establishmentLat,
      'establishment_long': establishmentLong,
      'delivery_method': deliveryMethod.name,
      'establishment_id': establishmentId,
      'user_address_id': userAddressId,
      'establishment_address_id': establishmentAddressId,
    };
  }
}
