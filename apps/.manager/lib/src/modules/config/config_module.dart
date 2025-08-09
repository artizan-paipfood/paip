import 'dart:async';
import 'package:manager/src/core/helpers/routes.dart';
import 'package:manager/src/core/logs/logs.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer_usecase.dart';
import 'package:manager/src/modules/config/aplication/usecases/save_information_establishment_usecase.dart';
import 'package:manager/src/modules/config/aplication/stores/aparence_store.dart';
import 'package:manager/src/modules/config/aplication/stores/opening_hours_store.dart';
import 'package:manager/src/modules/config/aplication/usecases/update_establishment_usecase.dart';
import 'package:manager/src/modules/config/presenters/appearance/appearance_page.dart';
import 'package:manager/src/modules/config/aplication/stores/information_store.dart';
import 'package:manager/src/modules/config/presenters/preferences/preferences_page.dart';
import 'package:manager/src/modules/config/presenters/information/information_page.dart';
import 'package:manager/src/modules/config/presenters/opening_hours/opening_hours_page.dart';
import 'package:manager/src/modules/config/sub_modules/payments/presenters/payments_page.dart';
import 'package:manager/src/modules/config/sub_modules/payments/payment_module.dart';
import 'package:manager/src/modules/config/presenters/printers/printer_page.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ConfigModule extends Module {
  @override
  FutureOr<List<Module>> imports() => [
        PaymentModule(),
      ];

  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.factory((i) => LayoutPrinterUsecase(api: i.get())),
        Bind.factory((i) => AddressApi(client: i.get())),
        Bind.factory((i) => SaveInformationEstablishmentUsecase(addressRepo: i.get(), dataSource: i.get(), establishmentRepo: i.get())),
        Bind.factory((i) => UpdateEstablishmentUsecase(establishmentRepo: i.get(), dataSource: i.get())),
        Bind.factory((i) => OpeningHoursRepository(http: i.get())),
        Bind.factory((i) => SearchAddressApi(client: ClientDio(baseOptions: HttpUtils.api(), talker: Logs.client.talker))),
        Bind.singleton((i) => AparenceStore(bucketRepo: i.get(), dataSource: i.get(), establishmentRepo: i.get(), saveInformationEstablishmentUsecase: i.get())),
        Bind.singleton((i) => InformationStore(dataSource: i.get(), saveInformationEstablishmentUsecase: i.get())),
        Bind.singleton((i) => OpeningStore(dataSource: i.get(), openingHoursRepo: i.get(), updateEstablishmentUsecase: i.get())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Routes.aparenceRelative,
          child: (context, args) => const AppearancePage(),
        ),
        ChildRoute(
          Routes.informationRelative,
          child: (context, args) => const InformationPage(),
        ),
        ChildRoute(
          Routes.paymentTypesRelative,
          child: (context, args) => const PaymentsPage(),
        ),
        ChildRoute(
          Routes.openingHoursRelative,
          child: (context, args) => const OpeningHoursPage(),
        ),
        ChildRoute(
          Routes.printerRelative,
          child: (context, args) => const PrinterPage(),
        ),
        ChildRoute(
          Routes.preferencesRelative,
          child: (context, args) => const PreferencesPage(),
        ),
      ];
}
