import 'dart:async';
import 'package:i18n/i18n.dart';
import 'package:manager/src/core/helpers/routes.dart';
import 'package:manager/src/core/logs/logs.dart';
import 'package:manager/src/core/stores/establishment_preferences_store.dart';
import 'package:manager/src/modules/auth/data/usecases/load_establishments_by_company_usecase.dart';
import 'package:manager/src/modules/auth/data/services/auth_service.dart';
import 'package:manager/src/modules/auth/data/usecases/auth_process_usecase.dart';
import 'package:manager/src/modules/auth/presenters/login_page.dart';
import 'package:manager/src/modules/auth/presenters/select_language_page.dart';
import 'package:manager/src/modules/auth/presenters/splash_page.dart';
import 'package:manager/src/modules/driver/aplication/usecases/load_driver_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AuthModule extends EventModule {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.factory((i) => MercadoPagoRepository(http: ClientDio(baseOptions: HttpUtils.mercadoPago, talker: Logs.client.talker))),
        Bind.factory((i) => AddressRepository(http: i.get())),
        Bind.factory((i) => OpeningHoursRepository(http: i.get())),
        Bind.factory((i) => DriverRepository(http: i.get())),
        Bind.factory((i) => LoadDriverUsecase(driverRepo: i.get(), dataSource: i.get())),
        Bind.factory((i) => DeliveryAreasPerMileRepository(http: i.get())),
        Bind.factory((i) => EstablishmentPreferencesRepository(client: i.get())),
        Bind.factory(
          (i) => LoadEstablishmentsByCompanyUsecase(
              dataSource: i.get(),
              establishmentRepo: i.get(),
              addressRepo: i.get(),
              openingHoursRepo: i.get(),
              deliveryAreasPerMileRepo: i.get(),
              layoutPrinterApi: i.get(),
              establishmentPreferencesViewmodel: i.get(),
              establishmentUsecase: i.get(),
              establishmentPreferencesNotifier: EstablishmentPreferencesStore.instance,
              establishmentPreferencesRepo: i.get()),
        ),
        Bind.singleton((i) => AuthService(
              authRepo: i.get(),
              getEstablishmentsByCompanyUsecase: i.get(),
              dataSource: i.get(),
              loadDeliveryMenUsecase: i.get(),
            )),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Routes.splashRelative, child: (context, args) => const SplashPage()),
        ChildRoute(Routes.loginRelative, child: (context, args) => const LoginPage()),
        ChildRoute(Routes.selectLanguageRelative, child: (context, args) => const SelectLanguagePage()),
      ];

  @override
  void listen() {
    on<SaveLanguage>((event, context) async {
      context.go(Routes.splash);
      await AuthProcessUsecase(context: context, authService: context.read<AuthService>()).call();
    });
  }
}
