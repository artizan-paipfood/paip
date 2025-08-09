import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DeliveryAreasPerMileStore extends ChangeNotifier {
  static DeliveryAreasPerMileStore? _instance;
  DeliveryAreasPerMileStore._();
  static DeliveryAreasPerMileStore get instance => _instance ??= DeliveryAreasPerMileStore._();

  final Map<String, DeliveryAreaPerMileEntity> _areas = {};
  List<DeliveryAreaPerMileEntity> get areas => _areas.values.toList()..sort((a, b) => a.radius.compareTo(b.radius));

  final ValueNotifier<DeliveryAreaPerMileEntity?> deliveryAreaPerMileNotifier = ValueNotifier(null);

  DeliveryAreaPerMileEntity? get deliveryAreaPerMile => deliveryAreaPerMileNotifier.value;

  void set(List<DeliveryAreaPerMileEntity> areas) {
    for (var area in areas) {
      _areas[area.id] = area;
    }
    notifyListeners();
  }

  void remove(String id) {
    _areas.remove(id);
    notifyListeners();
  }

  DeliveryAreaPerMileEntity? getAncestor(double radius) {
    return areas.firstWhereOrNull((e) => e.radius < radius);
  }

  void setDeliveryAreaPerMile(DeliveryAreaPerMileEntity? deliveryAreaPerMile) {
    deliveryAreaPerMileNotifier.value = deliveryAreaPerMile;
  }
}
