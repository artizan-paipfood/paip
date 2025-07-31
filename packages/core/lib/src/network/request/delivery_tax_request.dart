import 'package:core/core.dart';

class DeliveryTaxRequest {
  /// Represents the delivery tax information for an address.
  ///
  /// [lat] - The latitude of the origin location.
  /// [long] - The longitude of the origin location.
  /// [establishmentLat] - The latitude of the destination location.m/
  /// [establishmentLong] - The longitude of the destination location.
  /// [userAddessId] - The ID of the user's address (optional).
  /// [establishmentAddressId] - The ID of the establishment's address (optional).
  /// [deliveryMethod] - The method of delivery, either polygon or miles.
  /// [establishmentId] - The ID of the establishment.
  final double lat;
  final double long;
  final double establishmentLat;
  final double establishmentLong;
  final DeliveryMethod deliveryMethod;
  final String establishmentId;
  final String? userAddessId;
  final String establishmentAddressId;
  final DbLocale locale;

  DeliveryTaxRequest({required this.lat, required this.long, required this.establishmentLat, required this.establishmentLong, required this.deliveryMethod, required this.establishmentId, this.userAddessId, required this.establishmentAddressId, required this.locale}) {
    if (establishmentId.isEmpty) {
      throw FormatException('Establishment ID must be provided');
    }

    if (userAddessId != null && userAddessId!.isEmpty) {
      throw FormatException('User address ID must be provided');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "lat": lat,
      "long": long,
      "establishment_lat": establishmentLat,
      "establishment_long": establishmentLong,
      "user_address_id": userAddessId,
      "establishment_address_id": establishmentAddressId,
      "delivery_method": deliveryMethod.name,
      "establishment_id": establishmentId,
      "locale": locale.name,
    };
  }

  factory DeliveryTaxRequest.fromMap(Map<String, dynamic> map) {
    return DeliveryTaxRequest(
      lat: map['lat'],
      long: map['long'],
      establishmentLat: map['establishment_lat'],
      establishmentLong: map['establishment_long'],
      userAddessId: map['user_address_id'],
      establishmentAddressId: map['establishment_address_id'] ?? '',
      deliveryMethod: DeliveryMethod.fromMap(map['delivery_method']),
      establishmentId: map['establishment_id'],
      locale: DbLocale.fromMap(map['locale']),
    );
  }
}
