import 'package:paipfood_package/paipfood_package.dart';

class ImportDeliveryAreasByCityUsecase {
  final IDeliveryAreasRepository deliveryAreasRepo;
  final ILatLongsRepository latLongsRepo;
  ImportDeliveryAreasByCityUsecase({
    required this.deliveryAreasRepo,
    required this.latLongsRepo,
  });
  Future<void> call({required String city, required String establishmentId}) async {
    final deliveryAreas = await deliveryAreasRepo.getByCity(city);
    final latLongs = await latLongsRepo.getByCity(city);
    final groupLatlongs = latLongs.groupListsBy((element) => element.deliveryAreaId);

    final List<LatLongModel> newLatLongs = [];
    final List<DeliveryAreaModel> newDeliveryAreas = [];

    for (DeliveryAreaModel deliveryArea in deliveryAreas) {
      final newId = uuid;
      final oldId = deliveryArea.id;
      final newDeliveryArea = deliveryArea.copyWith(
        id: newId,
        establishmentId: establishmentId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      newDeliveryAreas.add(newDeliveryArea);
      for (LatLongModel latLong in groupLatlongs[oldId]!) {
        final newLatLong = latLong.copyWith(
          id: uuid,
          deliveryAreaId: newId,
          establishmentId: establishmentId,
          syncState: SyncState.upsert,
          createdAt: DateTime.now(),
        );
        newLatLongs.add(newLatLong);
      }
    }

    await deliveryAreasRepo.upsert(areas: newDeliveryAreas, auth: AuthNotifier.instance.auth);
    await latLongsRepo.upsert(latLongs: newLatLongs, auth: AuthNotifier.instance.auth);
  }
}
