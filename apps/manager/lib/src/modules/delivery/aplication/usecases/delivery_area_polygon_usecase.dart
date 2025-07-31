import 'package:manager/src/core/datasources/data_source.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DeliveryAreaPolygonUsecase {
  final DataSource dataSource;
  final IDeliveryAreasRepository deliveryAreasRepo;
  final LatLongsRepository latLongsRepo;
  DeliveryAreaPolygonUsecase({
    required this.dataSource,
    required this.deliveryAreasRepo,
    required this.latLongsRepo,
  });

  Future<DeliveryAreaModel> save({required DeliveryAreaModel deliveryArea, required List<LatLongModel> latLongs}) async {
    final result = await deliveryAreasRepo.upsert(areas: [deliveryArea], auth: AuthNotifier.instance.auth);
    await latLongsRepo.upsert(latLongs: latLongs, auth: AuthNotifier.instance.auth);
    final latlongsDeleted = latLongs.where((latLong) => latLong.isDeleted).toList();
    if (latlongsDeleted.isNotEmpty) {
      await latLongsRepo.delete(id: '', isDeleted: true, auth: AuthNotifier.instance.auth);
    }
    return result.first;
  }

  Future<void> delete(DeliveryAreaModel deliveryArea) async {
    await deliveryAreasRepo.delete(id: deliveryArea.id, auth: AuthNotifier.instance.auth);
  }
}
