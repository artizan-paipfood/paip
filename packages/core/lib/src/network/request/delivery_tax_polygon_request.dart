import 'dart:convert';

class DeliveryTaxPolygonRequest {
  final double lat;
  final double long;
  final String establishmentId;
  DeliveryTaxPolygonRequest({
    required this.lat,
    required this.long,
    required this.establishmentId,
  });

  factory DeliveryTaxPolygonRequest.fromMap(Map<String, dynamic> map) {
    return DeliveryTaxPolygonRequest(
      lat: map['lat']?.toDouble(),
      long: map['long']?.toDouble(),
      establishmentId: map['establishment_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'long': long,
      'establishment_id': establishmentId,
    };
  }

  String toJson() => json.encode(toMap());

  factory DeliveryTaxPolygonRequest.fromJson(String source) => DeliveryTaxPolygonRequest.fromMap(json.decode(source));
}
