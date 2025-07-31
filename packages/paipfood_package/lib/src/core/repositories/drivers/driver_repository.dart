import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DriverRepository implements IDriverRepository {
  final IClient http;
  DriverRepository({required this.http});

  static const String pathDriverEstablishments = '/rest/v1/driver_establishments';
  static const String pathDrivers = '/rest/v1/drivers';
  static const String pathDriverAndUserView = '/rest/v1/view_driver_and_user';
  static const String pathDriverEstablishmentAndUserView = '/rest/v1/view_drivers_establishments_and_user';

  @override
  Future<List<DriverAndUserAdapter>> getAllByEstablishmentId(String id) async {
    final req = await http.get("$pathDriverEstablishmentAndUserView?establishment_id=eq.$id&select=*");
    final List list = req.data;
    return list.map((e) => DriverAndUserAdapter.fromMap(e)).toList();
  }

  @override
  Future<List<DriverAndUserAdapter>> getAllByPhone(String phone) async {
    final req = await http.get("$pathDriverAndUserView?end_phone=eq.${phone.substring(phone.length - 4)}&select=*");
    final List list = req.data;
    return list.map((e) => DriverAndUserAdapter.fromMap(e)).toList();
  }

  @override
  Future<DriverAndUserAdapter?> getByUserId(String id) async {
    final req = await http.get("$pathDriverAndUserView?user_id=eq.$id&select=*");
    final List list = req.data;
    if (list.isEmpty) return null;
    return DriverAndUserAdapter.fromMap(list.first);
  }

  @override
  Future<DriverEstablishmentModel> linkEstablishment({required DriverEstablishmentModel driverEstablishment}) async {
    final request = await http.post(
      pathDriverEstablishments,
      data: driverEstablishment.toMap(),
      headers: HttpUtils.headerAuth(AuthNotifier.instance.auth),
    );
    final List list = request.data;
    return list.map<DriverEstablishmentModel>((e) {
      return DriverEstablishmentModel.fromMap(e);
    }).first;
  }

  @override
  Future<bool> linkEstablishmentAndDriverExists({required String establishmentId, required String driverId}) async {
    final req = await http.post(
      "/rest/v1/rpc/link_establishment_and_driver_exists",
      data: {"p_driver_id": driverId, "p_establishment_id": establishmentId},
      headers: HttpUtils.headerAuth(AuthNotifier.instance.auth),
    );
    return req.data;
  }

  @override
  Future<void> unlinkEstablishment({required String id}) async => await http.delete("$pathDriverEstablishments?id=eq.$id");

  @override
  Future<List<DriverModel>> upsert({required List<DriverModel> drivers, required AuthModel auth}) async {
    final data = drivers.map((e) => e.toMap()).toList();
    final request = await http.post(
      pathDrivers,
      headers: HttpUtils.headerUpsertAuth(auth),
      data: data,
    );
    final List list = request.data;
    return list.map<DriverModel>((product) {
      return DriverModel.fromMap(product);
    }).toList();
  }
}
