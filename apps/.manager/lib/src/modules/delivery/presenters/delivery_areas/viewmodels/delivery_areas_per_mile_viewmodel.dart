import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/stores/delivery_areas_per_mile_store.dart';
import 'package:manager/src/modules/delivery/aplication/usecases/delivery_area_per_mile_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DeliveryAreasPerMileViewmodel extends ChangeNotifier {
  final DeliveryAreaPerMileUsecase deliveryAreaPerMileUsecase;
  final DeliveryAreasPerMileStore store;

  DeliveryAreasPerMileViewmodel({required this.deliveryAreaPerMileUsecase, required this.store});

  String? selectedAreaId;

  List<DeliveryAreaPerMileEntity> _areas = [];

  final List<DeliveryAreaPerMileEntity> _areasToDelete = [];

  final Map<String, GlobalKey> _keys = {};

  Future<void> initialize() async {
    _areas = await deliveryAreaPerMileUsecase.get(establishmentId: establishmentProvider.value.id);
    for (var area in _areas) {
      _keys[area.id] = GlobalKey();
    }
  }

  List<DeliveryAreaPerMileEntity> get areas => _areas;

  Future<void> save() async {
    await deliveryAreaPerMileUsecase.upsert(areas: [..._areas, ..._areasToDelete]);
    if (_areasToDelete.isNotEmpty) {
      await deliveryAreaPerMileUsecase.delete(areas: _areasToDelete, authToken: AuthNotifier.instance.auth.accessToken!);
      _areasToDelete.clear();
    }
  }

  void onChange(DeliveryAreaPerMileEntity area) {
    final index = _areas.indexWhere((e) => e.id == area.id);
    _areas[index] = area;
    notifyListeners();
  }

  final scrollController = ScrollController();

  void toggleArea(String id) {
    selectedAreaId = selectedAreaId == id ? null : id;
    notifyListeners();
  }

  void delete(DeliveryAreaPerMileEntity area) {
    if (area.createdAt != null) _areasToDelete.add(area.copyWith(isDeleted: true));
    _areas.removeWhere((e) => e.id == area.id);
    sort();
  }

  GlobalKey key(String id) => _keys[id]!;

  void add() {
    sort();
    final last = _areas.last;
    final newArea = DeliveryAreaPerMileEntity(
      establishmentId: establishmentProvider.value.id,
      id: Uuid().v4(),
      radius: last.radius + 0.5,
      price: last.price + 0.5,
    );
    _keys[newArea.id] = GlobalKey();
    _areas.add(newArea);
    notifyListeners();
    Future.delayed(100.milliseconds, () {
      Scrollable.ensureVisible(key(newArea.id).currentContext!, duration: 500.milliseconds, curve: Curves.elasticInOut);
    });
  }

  void sort() {
    areas.sort((a, b) => a.radius.compareTo(b.radius));
    notifyListeners();
  }
}
