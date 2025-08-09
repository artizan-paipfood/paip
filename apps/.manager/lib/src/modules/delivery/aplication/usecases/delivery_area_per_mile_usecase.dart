import 'package:flutter/foundation.dart';
import 'package:core/core.dart';
import 'package:manager/src/core/stores/delivery_areas_per_mile_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DeliveryAreaPerMileUsecase extends ChangeNotifier {
  final IDeliveryAreasPerMileRepository repository;
  final DeliveryAreasPerMileStore store;
  DeliveryAreaPerMileUsecase({required this.repository, required this.store});

  Future<List<DeliveryAreaPerMileEntity>> get({required String establishmentId}) async {
    if (store.areas.isNotEmpty) return store.areas;
    List<DeliveryAreaPerMileEntity> result = [];
    result = await repository.getByEstablishmentId(establishmentId);
    if (result.isEmpty) {
      double radius = 0;
      double price = 3;
      final areas = List.generate(
        19,
        (index) {
          radius += 0.5;
          price += 0.5;
          return DeliveryAreaPerMileEntity(establishmentId: establishmentId, id: Uuid().v4(), radius: radius, price: price);
        },
      );
      await upsert(areas: areas);
      result.addAll(areas);
    }
    store.set(result);
    return store.areas;
  }

  Future<void> upsert({required List<DeliveryAreaPerMileEntity> areas}) async {
    await repository.upsert(areas: areas, authToken: AuthNotifier.instance.auth.accessToken!);
    store.set(areas);
  }

  Future<void> delete({required List<DeliveryAreaPerMileEntity> areas, required String authToken}) async {
    await repository.delete(authToken: authToken);
    for (var e in areas) {
      store.remove(e.id);
    }
  }
}
