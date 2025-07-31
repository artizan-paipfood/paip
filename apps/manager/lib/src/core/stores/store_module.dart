import 'dart:async';
import 'package:manager/src/core/stores/delivery_areas_per_mile_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class StoreModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.singleton((i) => DeliveryAreasPerMileStore.instance),
      ];
}
