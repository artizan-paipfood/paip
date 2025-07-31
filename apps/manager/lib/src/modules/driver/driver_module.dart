import 'dart:async';
import 'package:manager/src/core/helpers/routes.dart';
import 'package:manager/src/modules/driver/aplication/usecases/load_driver_usecase.dart';
import 'package:manager/src/modules/driver/domain/services/add_driver_service.dart';
import 'package:manager/src/modules/driver/presenters/pages/driver_page.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DriverModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.factory((i) => LoadDriverUsecase(driverRepo: i.get(), dataSource: i.get())),
        Bind.factory((i) => AddDriverService(driverRepo: i.get(), dataSource: i.get(), loadDriverUsecase: i.get())),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Routes.driversRelative,
          child: (context, args) => const DriverPage(),
        )
      ];
}
