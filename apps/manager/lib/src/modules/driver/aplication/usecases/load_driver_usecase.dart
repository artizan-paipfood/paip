import 'package:manager/src/core/datasources/data_source.dart';
import 'package:paipfood_package/paipfood_package.dart';

class LoadDriverUsecase {
  final DriverRepository driverRepo;
  final DataSource dataSource;
  LoadDriverUsecase({
    required this.driverRepo,
    required this.dataSource,
  });
  Future<List<DriverAndUserAdapter>> call({required String establishmentId}) async {
    final deliveryMen = await driverRepo.getAllByEstablishmentId(establishmentId);
    dataSource.deliveryMen = Map.fromEntries(deliveryMen.map((e) => MapEntry(e.user.id!, e)));
    return deliveryMen;
  }
}
