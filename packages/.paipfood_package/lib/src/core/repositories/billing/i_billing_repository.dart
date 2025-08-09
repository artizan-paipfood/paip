import 'package:paipfood_package/paipfood_package.dart';

abstract interface class IBillingRepository {
  Future<PlanAndInvoice> getCurrentInvoiceByEstablishmentId(String id);
  Future<List<EstablishmentInvoiceModel>> getInvoicesByEstablishmentId(String id);
  Future<EstablishmentInvoiceModel> upsert({required EstablishmentInvoiceModel establishmentInvoice, required AuthModel auth});
}
