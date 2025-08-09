import 'package:flutter/material.dart';

import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/driver/aplication/usecases/load_driver_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AddDriverService extends ChangeNotifier {
  final IDriverRepository driverRepo;
  final DataSource dataSource;
  final LoadDriverUsecase loadDriverUsecase;

  AddDriverService({
    required this.driverRepo,
    required this.dataSource,
    required this.loadDriverUsecase,
  });

  List<DriverAndUserAdapter> drivers = [];
  DriverAndUserAdapter? driver;

  Future<List<DriverAndUserAdapter>> getDeliveryMenByEndPhone(String phone) async => await driverRepo.getAllByPhone(phone);

  void setDrivers(List<DriverAndUserAdapter> drivers) {
    driver = null;
    this.drivers = drivers;
    notifyListeners();
  }

  ValueNotifier<int> rebuild = ValueNotifier(0);

  Future<void> loadDeleveryMen() async {
    await loadDriverUsecase.call(establishmentId: establishmentProvider.value.id);
    notifyListeners();
    rebuild.value++;
  }

  void setDriver(DriverAndUserAdapter driver) {
    this.driver = driver;
    notifyListeners();
  }

  Future<void> sendInvite(DriverAndUserAdapter driver) async {
    final inviteExist = await driverRepo.linkEstablishmentAndDriverExists(establishmentId: establishmentProvider.value.id, driverId: driver.user.id!);
    if (inviteExist) return;
    await driverRepo.linkEstablishment(
      driverEstablishment: DriverEstablishmentModel(
        createdAt: DateTime.now(),
        establishmentId: establishmentProvider.value.id,
        driverId: driver.user.id!,
        isAccepted: true,
      ),
    );
  }
}
