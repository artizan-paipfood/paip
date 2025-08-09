import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/config/aplication/usecases/update_establishment_usecase.dart';
import 'package:manager/src/modules/delivery/presenters/delivery_areas/viewmodels/delivery_areas_per_mile_viewmodel.dart';
import 'package:manager/src/modules/delivery/presenters/delivery_areas/viewmodels/delivery_areas_polygon_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DeliveryAreasViewmodel extends ChangeNotifier {
  final UpdateEstablishmentUsecase updateEstablishmentUsecase;
  final DataSource dataSource;
  final DeliveryAreasPerMileViewmodel deliveryAreaPerMileViewmodel;
  final DeliveryAreasPolygonViewmodel deliveryAreaPolygonViewmodel;
  DeliveryAreasViewmodel({
    required this.updateEstablishmentUsecase,
    required this.dataSource,
    required this.deliveryAreaPerMileViewmodel,
    required this.deliveryAreaPolygonViewmodel,
  });

  DeliveryMethod get deliveryMethod => establishmentProvider.value.deliveryMethod;

  Future<Status> load() async {
    await deliveryAreaPerMileViewmodel.initialize();
    await deliveryAreaPolygonViewmodel.load();
    return Status.complete;
  }

  late final listenables = Listenable.merge([this, deliveryAreaPerMileViewmodel, deliveryAreaPolygonViewmodel]);

  Future<void> changeDeliveryType(DeliveryMethod deliveryMethod) async {
    if (deliveryMethod == this.deliveryMethod) return;
    final result = establishmentProvider.value.copyWith(deliveryMethod: deliveryMethod);
    dataSource.setEstablishment(result);
    await updateEstablishmentUsecase.call();
    notifyListeners();
  }
}
