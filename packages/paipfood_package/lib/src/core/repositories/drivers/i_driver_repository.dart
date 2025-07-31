import 'package:paipfood_package/paipfood_package.dart';

abstract interface class IDriverRepository {
  Future<List<DriverModel>> upsert({required List<DriverModel> drivers, required AuthModel auth});
  Future<DriverEstablishmentModel> linkEstablishment({required DriverEstablishmentModel driverEstablishment});
  Future<void> unlinkEstablishment({required String id});
  Future<bool> linkEstablishmentAndDriverExists({required String establishmentId, required String driverId});
  Future<List<DriverAndUserAdapter>> getAllByEstablishmentId(String id);
  Future<DriverAndUserAdapter?> getByUserId(String id);
  Future<List<DriverAndUserAdapter>> getAllByPhone(String phone);
}
