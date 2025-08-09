import 'package:paipfood_package/paipfood_package.dart';

abstract interface class IOpeningHoursRepository {
  Future<List<OpeningHoursModel>> getByEstablishmentId(String id);
  Future<List<OpeningHoursModel>> getByEstablishmentIdAndWeekDAy({required String id, required int weekDay});
  Future<List<OpeningHoursModel>> upsert({required List<OpeningHoursModel> openingHours, required AuthModel auth});
  Future<void> delete({required String id, required AuthModel auth, bool isDeleted});
}
