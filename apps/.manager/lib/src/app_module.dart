import 'dart:async';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/helpers/routes.dart';
import 'package:manager/src/core/logs/logs.dart';
import 'package:manager/src/core/stores/establishment_preferences_store.dart';
import 'package:manager/src/core/services/establishment_service.dart';
import 'package:manager/src/core/stores/store_module.dart';
import 'package:manager/src/modules/config/aplication/usecases/update_establishment_usecase.dart';
import 'package:manager/src/modules/config/presenters/viewmodels/establishment_preferences_viewmodel.dart';
import 'package:manager/src/modules/config/presenters/viewmodels/user_preferences_viewmode.dart';
import 'package:manager/src/modules/home/aplication/usecases/close_establishment_usecase.dart';
import 'package:manager/src/modules/home/aplication/usecases/open_establishment_usecase.dart';
import 'package:manager/src/modules/home/aplication/usecases/scheaduling_estavlishment_close_usecase.dart';
import 'package:manager/src/modules/home/aplication/usecases/verify_establishment_is_open_usecase.dart';
import 'package:manager/src/modules/home/home_module.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AppModule extends Module {
  @override
  FutureOr<List<Module>> imports() => [StoreModule()];

  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.singleton((i) => UpdateEstablishmentUsecase(establishmentRepo: i.get(), dataSource: i.get())),
        Bind.singleton((i) => LocalStorageHive()),
        Bind.factory((i) => UpdateQueusRepository(http: i.get())),
        Bind.singleton((i) => MercadoPagoRepository(http: ClientDio(baseOptions: HttpUtils.mercadoPago, talker: Logs.client.talker))),
        Bind.singleton((i) => ClientDio(baseOptions: HttpUtils.supabaseBaseoptions, talker: Logs.client.talker)),
        Bind.singleton((i) => DataSource()),
        Bind.singleton((i) => UserPreferencesViewmodel(localStorage: i.get())),
        Bind.singleton((i) => EstablishmentRepository(http: i.get())),
        Bind.factory((i) => EstablishmentPreferencesRepository(client: i.get())),
        Bind.factory((i) => EstablishmentPreferencesViewmodel(updateEstablishmentUsecase: i.get(), establishmentPreferencesNotifier: EstablishmentPreferencesStore.instance, establishmentPreferencesRepo: i.get())),
        Bind.factory((i) => EstablishmentUsecase(repository: i.get())),
        Bind.factory((i) => CloseEstablishmentUsecase(establishmentRepo: i.get(), dataSource: i.get(), verifyEstablishmentIsOpenUsecase: i.get(), updateQueusRepo: i.get())),
        Bind.factory((i) => OpenEstablishmentUsecase(establishmentRepo: i.get(), dataSource: i.get(), scheadulingEstavlishmentCloseUsecase: i.get(), updateQueusRepo: i.get())),
        Bind.factory((i) => ScheadulingEstavlishmentCloseUsecase(establishmentRepo: i.get(), dataSource: i.get(), closeEstablishmentUsecase: i.get())),
        Bind.factory((i) => VerifyEstablishmentIsOpenUsecase(establishmentRepo: i.get(), dataSource: i.get())),
        Bind.singleton(
            (i) => EstablishmentService(http: ClientDio(baseOptions: BaseOptions(), talker: Logs.client.talker), dataSource: i.get(), establishmentRepo: i.get(), bucketRepo: i.get(), localStorage: i.get(), closeEstablishmentUsecase: i.get(), openEstablishmentUsecase: i.get())),
        Bind.singleton((i) => AuthRepository(http: i.get())),
        Bind.factory((i) => AwsClient(http: ClientDio(baseOptions: BaseOptions(), talker: Logs.client.talker))),
        Bind.factory((i) => LayoutPrinterApi(client: i.get())),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Routes.homeModule, module: HomeModule()),
      ];
}
