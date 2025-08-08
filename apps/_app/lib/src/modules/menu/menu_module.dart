import 'dart:async';
import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/menu/domain/services/menu_order_cache_service.dart';
import 'package:app/src/modules/menu/domain/services/payment_service.dart';
import 'package:app/src/modules/menu/domain/usecases/validate_order_rules_usecase.dart';
import 'package:app/src/modules/menu/presenters/view_models/cart_product_viewmodel.dart';
import 'package:app/src/modules/menu/presenters/view_models/menu_viewmodel.dart';
import 'package:app/src/modules/menu/presenters/view_models/order_viewmodel.dart';
import 'package:app/src/modules/menu/domain/usecases/get_menu_by_establishment_usecase.dart';
import 'package:app/src/modules/menu/domain/usecases/upsert_order_usecase.dart';
import 'package:app/src/modules/menu/domain/usecases/verify_is_open_establishment_usecase.dart';
import 'package:app/src/modules/menu/presenters/pages/cart_page.dart';
import 'package:app/src/modules/menu/presenters/pages/cart_product_page.dart';
import 'package:app/src/modules/menu/presenters/pages/menu_page.dart';
import 'package:paipfood_package/paipfood_package.dart';

class MenuModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.singleton((i) => StripeApi(client: ClientDio(baseOptions: HttpUtils.api()))),
        Bind.singleton((i) => ChargesRepository(client: i.get())),
        Bind.singleton((i) => PaymentService(menuViewmodel: i.get(), userStore: i.get(), chargesApi: i.get(), stripeApi: i.get())),
        Bind.singleton((i) => PaymentMethodRepository(http: i.get())),
        Bind.singleton((i) => CartProductViewmodel()),
        Bind.singleton((i) => BuildMenuFromMapUsecase()),
        Bind.singleton((i) => MercadoPagoRepository(http: ClientDio(baseOptions: HttpUtils.mercadoPago))),
        Bind.singleton((i) => GetMenuHttpUsecase(establishmentRepo: i.get())),
        Bind.singleton((i) => DeliveryAreasRepository(http: i.get())),
        Bind.singleton((i) => AddressApi(client: i.get())),
        Bind.singleton((i) => OrderRepository(http: i.get())),
        Bind.singleton((i) => CustomFunctionsRepository(http: ClientDio(baseOptions: HttpUtils.customFunctionsBaseOptions))),
        Bind.singleton((i) => OpeningHoursRepository(http: i.get())),
        Bind.singleton((i) => VerifyIsOpenEstablishmentUsecase(establishmentRepo: i.get())),
        Bind.singleton((i) => UpdateQueusRepository(http: i.get())),
        Bind.singleton((i) => UpsertOrderUsecase(orderRepo: i.get(), updateQueusRepo: i.get())),
        Bind.singleton((i) => MenuOrderCacheService(localStorage: i.get())),
        Bind.singleton((i) => OrderViewmodel(localStorage: i.get())),
        Bind.singleton((i) => DeliveryAreasPerMileRepository(http: i.get())),
        Bind.singleton((i) => ValidateOrderRulesUsecase(verifyIsOpenEstablishmentUsecase: i.get())),
        Bind.singleton((i) => GetMenuByEstablishmentUsecase(establishmentRepository: i.get(), getMenuHttpUsecase: i.get(), getMenuVObjUsecase: i.get(), paymentMethodRepo: i.get(), dataSource: i.get(), deliveryAreasPerMileRepository: i.get(), openingHoursRepo: i.get())),
        Bind.singleton(
          (i) => MenuViewmodel(
            getMenuAndEstablishmentUsecase: i.get(),
            userViewmodel: i.get(),
            dataSource: i.get(),
            upsertOrderUsecase: i.get(),
            menuOrderCacheService: i.get(),
            orderViewmodel: i.get(),
            authRepository: i.get(),
            phoneRefreshTokenMicroService: i.get(),
            deliveryAreaNotifier: i.get(),
            validateOrderRulesUsecase: i.get(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Routes.menuRelative,
          redirect: (context, state) {
            return _redirectDefault(state);
          },
          child: (context, state) => MenuPage(establishmentId: state.pathParameters[Routes.establishmentIdParam]!),
        ),
        ChildRoute(
          Routes.cartProductRelative,
          child: (context, state) => CartProductPage(productId: state.pathParameters[Routes.productIdParam]!),
          redirect: (context, state) {
            try {
              final store = Modular.get<MenuViewmodel>();
              if (store.status.value == Status.complete) return null;
            } catch (e) {
              return _redirectDefault(state);
            }
            return _redirectDefault(state);
          },
        ),
        ChildRoute(Routes.cartRelative, child: (context, state) => const CartPage()),
        // ChildRoute(
        //   Routes.paymentCreditCard,
        //   name: Routes.paymentCreditCard.name,
        //   child: (context, state) => const PaymentCreditCardPage(),
        // ),
      ];

  String? _redirectDefault(GoRouterState state) {
    final param = state.pathParameters[Routes.establishmentIdParam];
    if (param == null || param.isEmpty) return Routes.login;
    if (Utils.isUuidV4(param)) return null;
    return Routes.company(slug: param);
  }
}
