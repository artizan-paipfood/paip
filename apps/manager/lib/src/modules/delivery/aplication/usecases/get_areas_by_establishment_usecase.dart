import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/delivery/aplication/usecases/order_polygin_points_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class GetAreasByEstablishmentUsecase {
  final DataSource dataSource;
  final IDeliveryAreasRepository deliveryAreasRepo;
  final LatLongsRepository latLongsRepo;
  final OrderPolyginPointsUsecase orderPolyginPointsUsecase;
  GetAreasByEstablishmentUsecase({
    required this.dataSource,
    required this.deliveryAreasRepo,
    required this.latLongsRepo,
    required this.orderPolyginPointsUsecase,
  });
  Future<List<DeliveryAreaModel>> call() async {
    final establishment = establishmentProvider.value;
    final establishmentId = establishment.id;

    final future = await Future.wait([
      deliveryAreasRepo.getByEstablishmentId(establishmentId),
      latLongsRepo.getByEstablishmentId(establishmentId),
    ]);
    final List<DeliveryAreaModel> deliveryAreas = future[0] as List<DeliveryAreaModel>;
    final List<LatLongModel> latLongs = future[1] as List<LatLongModel>;

    // Group latLongs by establishment
    final Map<String, List<LatLongModel>> latLongsGrouped = latLongs.groupListsBy(
      (element) => element.deliveryAreaId,
    );

    deliveryAreas.map((area) => area.latLongs = latLongsGrouped[area.id] ?? []).toList();

    await Future.wait(deliveryAreas.map((area) async {
      await orderPolyginPointsUsecase.call(latLongs: area.latLongs, establishmentId: area.establishmentId);
    }));
    return deliveryAreas;
  }
}
