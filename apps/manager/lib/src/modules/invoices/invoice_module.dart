import 'dart:async';
import 'package:manager/src/modules/invoices/domain/usecases/invoices_usecase.dart';
import 'package:manager/src/modules/invoices/presenters/viewmodels/invoice_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class InvoiceModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.singleton((i) => InvoiceViewmodel(usecase: i.get())),
        Bind.factory((i) => EstablishmentInvoiceRepository(client: i.get())),
        Bind.factory((i) => EstablishmentRepository(http: i.get())),
        Bind.factory((i) => HipayApi(client: ClientDio(baseOptions: HttpUtils.api()))),
        Bind.factory((i) => InvoicesUsecase(establishmentInvoiceRepo: i.get(), establishmentRepository: i.get(), hipayApi: i.get())),
      ];
}
