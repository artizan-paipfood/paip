import 'dart:convert';

class DeliveryTaxPolygonResponse {
  final double price;
  String? deliveryAreaId;
  DeliveryTaxPolygonResponse({
    required this.price,
    this.deliveryAreaId,
  });

  DeliveryTaxPolygonResponse copyWith({
    double? price,
    String? deliveryAreaId,
  }) {
    return DeliveryTaxPolygonResponse(
      price: price ?? this.price,
      deliveryAreaId: deliveryAreaId ?? this.deliveryAreaId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'delivery_area_id': deliveryAreaId,
    };
  }

  factory DeliveryTaxPolygonResponse.fromMap(Map<String, dynamic> map) {
    return DeliveryTaxPolygonResponse(
      price: map['price'] ?? 0.0,
      deliveryAreaId: map['delivery_area_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryTaxPolygonResponse.fromJson(String source) => DeliveryTaxPolygonResponse.fromMap(json.decode(source));
}
