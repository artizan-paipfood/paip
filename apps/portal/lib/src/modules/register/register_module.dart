import 'dart:async';
import 'package:portal/src/core/helpers/routes.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/src/modules/register/register/aplication/controllers/register_controller.dart';
import 'package:portal/src/modules/register/register/aplication/stores/register_store.dart';
import 'package:portal/src/modules/register/register/aplication/usecases/insert_user_company_establishment_usecase.dart';
import 'package:portal/src/modules/register/register/presenters/pages/create_establishment_status_page.dart';
import 'package:portal/src/modules/register/register/presenters/pages/register_page.dart';

class RegisterModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.singleton((i) => RegisterStore()),
        Bind.factory((i) => SearchAddressApi(client: ClientDio(baseOptions: HttpUtils.api()))),
        Bind.factory((i) => AddressRepository(http: i.get())),
        Bind.factory((i) => AuthRepository(http: i.get())),
        Bind.factory((i) => EstablishmentRepository(http: i.get())),
        Bind.factory((i) => DeliveryAreasRepository(http: i.get())),
        Bind.factory((i) => DeliveryAreasPerMileRepository(http: i.get())),
        Bind.factory((i) => LatLongsRepository(http: i.get())),
        Bind.factory((i) => ImportDeliveryAreasByCityUsecase(deliveryAreasRepo: i.get(), latLongsRepo: i.get())),
        Bind.factory((i) => PaymentMethodRepository(http: i.get())),
        Bind.factory((i) => InsertUserCompanyEstablishmentUsecase(deliveryAreasPerMileRepo: i.get(), addressRepo: i.get(), authRepo: i.get(), establishmentRepo: i.get(), importDeliveryAreasByCityUsecase: i.get(), paymentMethodRepo: i.get())),
        Bind.singleton((i) => RegisterController(authRepository: i.get(), store: i.get(), establishmentRepository: i.get(), insertCompanyUsecase: i.get())),
      ];

  @override
  List<ModularRoute> get routes => [ChildRoute(Routes.registerRelative, child: (context, args) => const RegisterPage()), ChildRoute(Routes.createEstablishmentStatusRelative, child: (context, args) => const CreateEstablishmentStatusPage())];
}
