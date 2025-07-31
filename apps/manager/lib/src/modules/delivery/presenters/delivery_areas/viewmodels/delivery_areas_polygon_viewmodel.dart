import 'package:flutter/material.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/delivery/aplication/usecases/get_areas_by_establishment_usecase.dart';
import 'package:manager/src/modules/delivery/aplication/usecases/order_polygin_points_usecase.dart';
import 'package:manager/src/modules/delivery/aplication/usecases/delivery_area_polygon_usecase.dart';
import 'package:manager/src/modules/delivery/domain/utils/colors_utils.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DeliveryAreasPolygonViewmodel extends ChangeNotifier {
  final DataSource dataSource;
  final GetAreasByEstablishmentUsecase getAreasByEstablishmentUsecase;
  final DeliveryAreaPolygonUsecase deliveryAreaPolygonUsecase;
  final OrderPolyginPointsUsecase orderPolyginPointsUsecase;
  final ImportDeliveryAreasByCityUsecase importDeliveryAreasByCityUsecase;

  DeliveryAreasPolygonViewmodel({
    required this.dataSource,
    required this.getAreasByEstablishmentUsecase,
    required this.deliveryAreaPolygonUsecase,
    required this.orderPolyginPointsUsecase,
    required this.importDeliveryAreasByCityUsecase,
  });

  final scrollController = ScrollController();
  DeliveryAreaModel? selectedArea;
  bool isArea = true;

  List<DeliveryAreaModel> _deliveryAreas = [];

  List<DeliveryAreaModel> get deliveryAreasSortByLabel => _deliveryAreas.sorted((a, b) => a.label.compareTo(b.label));

  EstablishmentModel get establishment => establishmentProvider.value;

  Future<void> load() async {
    _deliveryAreas = await getAreasByEstablishmentUsecase.call();
  }

  // selectedArea
  void cleanSelectedArea() {
    selectedArea = null;
    notifyListeners();
  }

  Future<void> import() async {
    await importDeliveryAreasByCityUsecase.call(city: establishment.city, establishmentId: establishment.id);
  }

  Future<void> addMarker({required LatLng latLng}) async {
    selectedArea!.latLongs.add(
      LatLongModel(
        id: uuid,
        deliveryAreaId: selectedArea!.id,
        latLng: latLng,
        establishmentId: selectedArea!.establishmentId,
        city: establishmentProvider.value.city,
        updatedAt: DateTime.now(),
      ),
    );
    final latlongs = await orderPolyginPointsUsecase.call(
      latLongs: selectedArea!.latLongs,
      establishmentId: selectedArea!.establishmentId,
    );
    if (selectedArea!.latLongs.isNotEmpty) selectedArea!.latLongs = latlongs;
    notifyListeners();
  }

  void cleanOrSelectArea({required DeliveryAreaModel area}) {
    if (selectedArea == null) {
      selectedArea = area;
      notifyListeners();
    } else {
      cleanSelectedArea();
    }
  }

  void onTapMap(LatLng latLng) {
    addMarker(latLng: latLng);
  }

  Future<void> addArea({LatLng? point}) async {
    final int qtd = _deliveryAreas.length;
    final String nameArea = qtd >= 1 ? "Area $qtd" : "Area";

    final area = DeliveryAreaModel(
      id: uuid,
      color: ColorsUtils.randomColor,
      label: nameArea,
      latLongs: [],
      establishmentId: establishment.id,
      city: establishment.city,
    );
    selectedArea = area;

    _deliveryAreas.add(area);
    await scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    notifyListeners();
  }

  Future<void> deleteArea({required DeliveryAreaModel area}) async {
    final index = _deliveryAreas.indexOf(area);
    if (area.createdAt != null) {
      await deliveryAreaPolygonUsecase.delete(area.copyWith(isDeleted: true));
    }
    selectedArea = null;
    _deliveryAreas.removeAt(index);
    notifyListeners();
  }

  void removeArea({required DeliveryAreaModel area}) {
    selectedArea = null;
    final index = _deliveryAreas.indexOf(area);
    _deliveryAreas.removeAt(index);
    notifyListeners();
  }

  void removeMarker({required DeliveryAreaModel area, required LatLongModel point}) {
    final index = area.latLongs.indexOf(point);
    area.latLongs.removeAt(index);
    area.latLongs.insert(index, point.copyWith(isDeleted: true));
    if (area.latLongs.where((l) => l.isDeleted == false).isEmpty) deleteArea(area: area);
    notifyListeners();
  }

  Future<void> save(DeliveryAreaModel area) async {
    selectedArea = null;

    final index = _deliveryAreas.indexOf(area);
    if (area.latLongs.isEmpty) {
      _deliveryAreas.remove(area);
      notifyListeners();
      return;
    }
    final latlongs = area.latLongs.where((element) => element.updatedAt != null).toList();
    final newDeliveryArea = await deliveryAreaPolygonUsecase.save(deliveryArea: area, latLongs: latlongs);
    _deliveryAreas
      ..removeAt(index)
      ..insert(index, newDeliveryArea.copyWith(latLongs: latlongs));
    notifyListeners();
  }

  void changeColorArea({required Color color, required DeliveryAreaModel area}) {
    area.color = color;
    notifyListeners();
  }
}
