import 'package:paipfood_package/paipfood_package.dart';

abstract interface class IBillRepository {
  Future<List<BillModel>> getByEstablishmentId(String id);
  Future<List<BillModel>> getByEstablishmentIdWithInterval({required String establishmentId, DateTime? initialDate, DateTime? endDate});
  Future<BillModel> getById(String id);
  Future<List<BillModel>> upsert({required List<BillModel> bills, required AuthModel auth});
  Future<void> delete({required String id, required AuthModel auth, bool isDeleted});
}
