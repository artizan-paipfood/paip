import 'dart:async';
import 'package:app/src/core/data/data_source.dart';
import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/core/notifiers/delivery_area_notifier.dart';
import 'package:app/src/modules/auth/auth_module.dart';
import 'package:app/src/modules/company/company_module.dart';
import 'package:app/src/modules/menu/menu_module.dart';
import 'package:app/src/modules/order/order_module.dart';
import 'package:app/src/modules/user/user_module.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AppModule extends Module {
  @override
  FutureOr<List<Module>> imports() => [UserModule()];

  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.singleton<ILocalStorage>((i) => LocalStorageSharedPreferences.instance),
        Bind.singleton((i) => ClientDio(baseOptions: HttpUtils.supabaseBaseoptions)),
        Bind.singleton((i) => EstablishmentRepository(http: i.get())),
        Bind.singleton((i) => TwillioMessageRepository(http: ClientDio(baseOptions: BaseOptions()))),
        Bind.singleton((i) => AuthRepository(http: i.get())),
        Bind.singleton((i) => DataSource()),
        Bind.factory((i) => DeliveryAreasRepository(http: i.get())),
        Bind.factory((i) => SearchAddressApi(client: ClientDio(baseOptions: HttpUtils.api()))),
        Bind.singleton((i) => DeliveryAreaNotifier(searchAddressRepository: i.get())),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Routes.authModule, module: AuthModule()),
        ModuleRoute(Routes.companyModule, module: CompanyModule()),
        ModuleRoute(Routes.menuModule, module: MenuModule()),
        ModuleRoute(Routes.orderModule, module: OrderModule()),
        ModuleRoute(Routes.userModule, module: UserModule()),
      ];
}
