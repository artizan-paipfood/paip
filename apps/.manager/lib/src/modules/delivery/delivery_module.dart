import 'dart:async';
import 'package:manager/src/core/helpers/routes.dart';
import 'package:manager/src/modules/delivery/aplication/usecases/delivery_area_per_mile_usecase.dart';
import 'package:manager/src/modules/delivery/aplication/usecases/get_areas_by_establishment_usecase.dart';
import 'package:manager/src/modules/delivery/aplication/usecases/order_polygin_points_usecase.dart';
import 'package:manager/src/modules/delivery/aplication/usecases/delivery_area_polygon_usecase.dart';
import 'package:manager/src/modules/delivery/presenters/delivery_areas/pages/delivery_areas_page.dart';
import 'package:manager/src/modules/delivery/presenters/delivery_areas/viewmodels/delivery_areas_per_mile_viewmodel.dart';
import 'package:manager/src/modules/delivery/presenters/delivery_areas/viewmodels/delivery_areas_polygon_viewmodel.dart';
import 'package:manager/src/modules/delivery/presenters/delivery_areas/viewmodels/delivery_areas_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DeliveryModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.factory((i) => OrderPolyginPointsUsecase()),
        Bind.factory((i) => DeliveryAreaPolygonUsecase(dataSource: i.get(), deliveryAreasRepo: i.get(), latLongsRepo: i.get())),
        Bind.factory((i) => GetAreasByEstablishmentUsecase(dataSource: i.get(), deliveryAreasRepo: i.get(), latLongsRepo: i.get(), orderPolyginPointsUsecase: i.get())),
        Bind.factory((i) => DeliveryAreasRepository(http: i.get())),
        Bind.factory((i) => LatLongsRepository(http: i.get())),
        Bind.factory((i) => ImportDeliveryAreasByCityUsecase(deliveryAreasRepo: i.get(), latLongsRepo: i.get())),
        Bind.factory((i) => DeliveryAreaPerMileUsecase(repository: i.get(), store: i.get())),
        Bind.factory((i) => DeliveryAreasPerMileRepository(http: i.get())),
        Bind.singleton((i) => DeliveryAreasPerMileViewmodel(deliveryAreaPerMileUsecase: i.get(), store: i.get())),
        Bind.singleton((i) => DeliveryAreasPolygonViewmodel(importDeliveryAreasByCityUsecase: i.get(), dataSource: i.get(), getAreasByEstablishmentUsecase: i.get(), deliveryAreaPolygonUsecase: i.get(), orderPolyginPointsUsecase: i.get())),
        Bind.singleton(
          (i) => DeliveryAreasViewmodel(
            updateEstablishmentUsecase: i.get(),
            dataSource: i.get(),
            deliveryAreaPerMileViewmodel: i.get(),
            deliveryAreaPolygonViewmodel: i.get(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Routes.deliveryAreasRelative,
          child: (context, args) => const DeliveryAreasPage(),
        ),
      ];
}
