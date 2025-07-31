import 'dart:convert';
import 'package:core/core.dart';

class DeliveryTaxResponse {
  final double? distance;
  final double straightDistance;
  final double price;
  final String? deliveryAreaId;
  final DeliveryMethod deliveryMethod;
  DeliveryTaxResponse({required this.deliveryMethod, required this.straightDistance, required this.price, this.distance, this.deliveryAreaId});

  DeliveryTaxResponse copyWith({double? distance, double? straightDistance, double? price, String? deliveryAreaId, DeliveryMethod? deliveryMethod}) {
    return DeliveryTaxResponse(distance: distance ?? this.distance, straightDistance: straightDistance ?? this.straightDistance, price: price ?? this.price, deliveryAreaId: deliveryAreaId ?? this.deliveryAreaId, deliveryMethod: deliveryMethod ?? this.deliveryMethod);
  }

  Map<String, dynamic> toMap() {
    return {'distance': distance, 'straight_distance': straightDistance, 'price': price, 'delivery_method': deliveryMethod.name, 'delivery_area_id': deliveryAreaId};
  }

  factory DeliveryTaxResponse.fromMap(Map<String, dynamic> map) {
    return DeliveryTaxResponse(distance: map['distance']?.toDouble(), straightDistance: map['straight_distance']?.toDouble(), price: map['price']?.toDouble(), deliveryMethod: DeliveryMethod.fromMap(map['delivery_method']), deliveryAreaId: map['delivery_area_id']);
  }

  String toJson() => json.encode(toMap());

  factory DeliveryTaxResponse.fromJson(String source) => DeliveryTaxResponse.fromMap(json.decode(source));
}
