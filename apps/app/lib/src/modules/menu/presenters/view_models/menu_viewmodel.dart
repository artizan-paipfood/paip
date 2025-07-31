import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app/src/core/data/data_source.dart';
import 'package:app/src/core/notifiers/delivery_area_notifier.dart';
import 'package:app/src/core/utils/delivery_tax_debug.dart';
import 'package:app/src/modules/menu/domain/services/facebook_pixel.dart';
import 'package:app/src/modules/menu/domain/services/menu_order_cache_service.dart';
import 'package:app/src/modules/menu/domain/usecases/validate_order_rules_usecase.dart';
import 'package:app/src/modules/menu/presenters/view_models/order_viewmodel.dart';
import 'package:app/src/modules/menu/domain/usecases/get_menu_by_establishment_usecase.dart';
import 'package:app/src/modules/menu/domain/usecases/upsert_order_usecase.dart';
import 'package:app/src/modules/menu/domain/models/data_establishment_dto.dart';
import 'package:app/src/modules/user/presenters/viewmodels/user_store.dart';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class MenuViewmodel extends ChangeNotifier {
  final GetMenuByEstablishmentUsecase getMenuAndEstablishmentUsecase;
  final UserStore userViewmodel;
  final DataSource dataSource;
  final UpsertOrderUsecase upsertOrderUsecase;
  final MenuOrderCacheService menuOrderCacheService;
  final OrderViewmodel orderViewmodel;
  final DeliveryAreaNotifier deliveryAreaNotifier;
  final PhoneRefreshTokenService phoneRefreshTokenMicroService;
  final AuthRepository authRepository;
  final ValidateOrderRulesUsecase validateOrderRulesUsecase;

  MenuViewmodel({
    required this.getMenuAndEstablishmentUsecase,
    required this.userViewmodel,
    required this.dataSource,
    required this.upsertOrderUsecase,
    required this.menuOrderCacheService,
    required this.orderViewmodel,
    required this.deliveryAreaNotifier,
    required this.phoneRefreshTokenMicroService,
    required this.authRepository,
    required this.validateOrderRulesUsecase,
  });
  final formKey = GlobalKey<FormState>();

  ValueNotifier<StateData> status = ValueNotifier(StateData.loading());

  bool addressConfirmed = false;

  late final listenables = Listenable.merge([this, userViewmodel, orderViewmodel, deliveryAreaNotifier]);

  ProductModel? getProductById(String productId) {
    return menu.products[productId];
  }

  DataEstablishmentDto? _dataEstablishment;
  DataEstablishmentDto get dataEstablishment {
    assert(_dataEstablishment != null, "Establishment not initialized");
    return _dataEstablishment!;
  }

  MenuDto get menu => dataEstablishment.menu;
  EstablishmentModel get establishment => dataEstablishment.establishment;

  OpeningHoursModel? get openingHour {
    return dataEstablishment.openingHours.firstWhereOrNull((hour) => hour.openingEnumValue.buildNow.isBefore(DateTime.now()) && hour.closingEnumValue.buildNow.isAfter(DateTime.now()));
  }

  bool get minimumOrderNotReached => establishment.minimunOrder > orderViewmodel.order.getSubTotal;

  List<CategoryModel> get categories => menu.categories.values.sorted((a, b) => a.index.compareTo(b.index)).toList();

  double get getDeliveryTax {
    if (!orderType.isDelivery) {
      return 0;
    }

    final deliveryTax = deliveryAreaNotifier.deliveryTax;

    // CORREÇÃO: Se não há taxa carregada, tenta carregar ou define como undefined
    if (deliveryTax == null) {
      if (kDebugMode) {
        print('⚠️ Taxa de entrega não encontrada - tentando recarregar ou resetando orderType');
        DeliveryTaxDebug.logDeliveryState(
          deliveryAreaNotifier: deliveryAreaNotifier,
          orderType: orderType,
          userAddress: AuthNotifier.instance.auth.user?.getAddress,
          establishmentAddress: establishment.address,
          context: 'getDeliveryTax - taxa não carregada',
        );
      }

      // Tenta carregar a taxa automaticamente em background
      _tryLoadDeliveryTaxInBackground();

      // Por enquanto retorna 0 para não quebrar a UI
      return 0;
    }

    // Garante que nunca retorna valor negativo
    final price = deliveryTax.price;
    if (price < 0) {
      if (kDebugMode) {
        print('⚠️ Taxa negativa detectada: $price - retornando 0');
      }
      return 0;
    }

    return price;
  }

  /// Tenta carregar a taxa em background e se falhar, reseta o orderType
  void _tryLoadDeliveryTaxInBackground() async {
    try {
      final user = AuthNotifier.instance.auth.user;
      final userAddress = user?.getAddress;

      if (user != null && userAddress != null) {
        await deliveryAreaNotifier.loadDeliveryTax(
          address: userAddress,
          establishmentAddress: establishment.address!,
          deliveryMethod: establishment.deliveryMethod,
          forceReload: true,
        );

        // Se chegou até aqui, a taxa foi carregada com sucesso
        notifyListeners(); // Atualiza a UI

        if (kDebugMode) {
          print('✅ Taxa de entrega carregada automaticamente');
        }
      } else {
        // Sem usuário ou endereço válido, reseta para undefined
        _resetOrderTypeToUndefined('Usuário ou endereço inválido');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Falha ao carregar taxa automaticamente: $e');
      }

      // Se falhar, reseta o orderType para forçar nova seleção
      _resetOrderTypeToUndefined('Falha ao carregar taxa de entrega');
    }
  }

  /// Reseta o orderType para undefined quando há problemas com a taxa
  void _resetOrderTypeToUndefined(String reason) {
    if (kDebugMode) {
      print('🔄 Resetando orderType para undefined: $reason');
    }

    _orderType = OrderTypeEnum.undefined;
    deliveryAreaNotifier.clearDeliveryTaxCache();
    notifyListeners();
  }

  double get getTotal {
    final subtotal = orderViewmodel.getSubtotalMinusDiscounts;
    final deliveryTax = getDeliveryTax;
    final total = subtotal + deliveryTax;

    // Debug apenas quando há problemas potenciais (performance otimizada)
    if (kDebugMode && orderType.isDelivery && deliveryTax == 0) {
      DeliveryTaxDebug.logDeliveryState(
        deliveryAreaNotifier: deliveryAreaNotifier,
        orderType: orderType,
        userAddress: AuthNotifier.instance.auth.user?.getAddress,
        establishmentAddress: establishment.address,
        context: 'getTotal - taxa zero detectada',
      );
    }

    return total;
  }

  OrderTypeEnum _orderType = OrderTypeEnum.undefined;

  OrderTypeEnum get orderType => _orderType;

  /// Define o tipo de pedido, garantindo que a taxa de entrega seja carregada para delivery
  Future<void> setOrderType(OrderTypeEnum orderType) async {
    // CORREÇÃO: Se mudando para delivery, garante que a taxa esteja carregada
    if (orderType.isDelivery) {
      final user = AuthNotifier.instance.auth.user;
      final userAddress = user?.getAddress;

      if (user == null) {
        throw Exception('Usuário deve estar logado para pedidos de entrega');
      }

      if (userAddress == null) {
        throw Exception('Endereço de entrega deve estar definido');
      }

      // Força o carregamento da taxa se não estiver carregada
      if (deliveryAreaNotifier.deliveryTax == null) {
        if (kDebugMode) {
          print('🔄 Carregando taxa de entrega obrigatória para tipo delivery...');
        }

        try {
          await deliveryAreaNotifier.loadDeliveryTax(
            address: userAddress,
            establishmentAddress: establishment.address!,
            deliveryMethod: establishment.deliveryMethod,
            forceReload: true,
          );
        } catch (e) {
          if (kDebugMode) {
            print('❌ Erro ao carregar taxa obrigatória: $e');
          }
          throw Exception('Não foi possível calcular a taxa de entrega. Verifique o endereço e tente novamente.');
        }
      }
    }

    _orderType = orderType;
    notifyListeners();
  }

  void notify() => notifyListeners();

  Future<StateData> initializeEstablishment(BuildContext context, {required String establishmentId}) async {
    _reset();
    _dataEstablishment = await getMenuAndEstablishmentUsecase.call(establishmentId);
    deliveryAreaNotifier.setDeliveryMethod(dataEstablishment.establishment.deliveryMethod);
    if (context.mounted) _callFacebookPixel(context, facebookPixel: dataEstablishment.establishment.facebookPixel);
    await _refreshToken();
    menuOrderCacheService.cacheTimer = DateTime.now().add(10.minutes);

    await orderViewmodel.loadCache(establishmentId);
    status.value = StateData.complete();
    return StateData.complete();
  }

  _callFacebookPixel(BuildContext context, {String? facebookPixel}) {
    if (facebookPixel == null) return;
    WidgetsBinding.instance.addPostFrameCallback((timeStam) {
      injectFacebookPixel(facebookPixel);
    });
  }

  void changeTheme(bool isDarkTheme) => ThemeNotifier.instance.toggleMode();

  Future<void> _refreshToken() async {
    try {
      await AuthNotifier.instance.initialize(PhoneRefreshTokenService(authRepository: authRepository));
      final auth = await phoneRefreshTokenMicroService.refreshToken();
      AuthNotifier.instance.update(auth);
      Sentry.configureScope((scope) => scope.setUser(SentryUser(id: auth.user!.id, name: auth.user!.name)));
      await userViewmodel.loadAdress();
      _orderType = establishment.getAvailableByAddress(AuthNotifier.instance.auth.user!.getAddress);
      if (_orderType.isDelivery) {
        await deliveryAreaNotifier.loadDeliveryTax(
          address: AuthNotifier.instance.auth.user!.getAddress!,
          establishmentAddress: establishment.address!,
          deliveryMethod: establishment.deliveryMethod,
          forceReload: true,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Erro ao refreshar token e carregar taxa: $e');
      }

      if (e.isAInternalException<AddressOutOfDeliveryRadiusException>()) {
        setOrderType(OrderTypeEnum.undefined);
        return;
      }
    }
  }

  void _reset() {
    userViewmodel.reset();
  }

  Future<void> validateOrderRules(BuildContext context) async {
    if (orderType.isDelivery) {
      validateOrderRulesUsecase.maxDistance(context, distance: deliveryAreaNotifier.deliveryTax?.distance ?? deliveryAreaNotifier.deliveryTax?.straightDistance ?? 0, maxDistance: establishment.maxDistance);
    }

    validateOrderRulesUsecase.orderType(context, orderType: orderType);

    // NOVA VALIDAÇÃO CRÍTICA: Verifica se taxa de entrega está correta
    validateOrderRulesUsecase.deliveryTax(context, orderType: orderType, deliveryAreaNotifier: deliveryAreaNotifier);

    await validateOrderRulesUsecase.isOpen(context, establishmentId: establishment.id);
  }

  Future<OrderModel> saveOrder({required PaymentType paymentType, String? paymentLink}) async {
    // VALIDAÇÃO CRÍTICA: Garante que pedidos delivery sempre tenham taxa carregada
    if (orderType.isDelivery) {
      final deliveryTaxValue = deliveryAreaNotifier.deliveryTax?.price;

      if (deliveryAreaNotifier.deliveryTax == null) {
        if (kDebugMode) {
          print('❌ TENTATIVA DE SALVAR PEDIDO DELIVERY SEM TAXA - tentando carregar...');
          DeliveryTaxDebug.logDeliveryState(
            deliveryAreaNotifier: deliveryAreaNotifier,
            orderType: orderType,
            userAddress: AuthNotifier.instance.auth.user?.getAddress,
            establishmentAddress: establishment.address,
            context: 'saveOrder - validação crítica falhou',
          );
        }

        // CORREÇÃO: Tenta carregar a taxa uma última vez antes de falhar
        try {
          final user = AuthNotifier.instance.auth.user;
          final userAddress = user?.getAddress;

          if (user != null && userAddress != null) {
            await deliveryAreaNotifier.loadDeliveryTax(
              address: userAddress,
              establishmentAddress: establishment.address!,
              deliveryMethod: establishment.deliveryMethod,
              forceReload: true,
            );

            if (kDebugMode) {
              print('✅ Taxa carregada com sucesso no último momento');
            }
          } else {
            throw Exception('Usuário ou endereço não disponível para calcular taxa de entrega.');
          }
        } catch (e) {
          if (kDebugMode) {
            print('❌ Falha final ao carregar taxa: $e');
          }
          throw Exception('Não foi possível calcular a taxa de entrega. Por favor, verifique seu endereço e tente novamente.');
        }
      }

      // Validação final do valor da taxa
      final finalTaxValue = deliveryAreaNotifier.deliveryTax?.price ?? 0;

      // Log de segurança para auditoria
      if (kDebugMode) {
        DeliveryTaxDebug.logOrderCalculation(
          subtotal: orderViewmodel.getSubtotalMinusDiscounts,
          deliveryTax: finalTaxValue,
          discount: orderViewmodel.order.discount,
          total: orderViewmodel.getSubtotalMinusDiscounts + finalTaxValue - orderViewmodel.order.discount,
          orderType: orderType,
        );
      }
    }

    final result = await upsertOrderUsecase.call(
      orderViewmodel.order.copyWith(
        establishmentId: establishment.id,
        paymentType: paymentType,
        orderType: orderType,
        customer: CustomerModel.fromUser(AuthNotifier.instance.auth.user).copyWith(addresses: []),
        isLocal: false,
        dateLimit: DateTime.now().add(5.minutes),
        deliveryTax: getDeliveryTax,
      ),
    );
    await orderViewmodel.deleteCache();
    return result;
    // _reset();
  }

  handleOrderType() {
    if (_orderType.isDelivery && AuthNotifier.instance.auth.user?.getAddress == null) {
      _orderType = OrderTypeEnum.undefined;
      deliveryAreaNotifier.clearDeliveryTaxCache();
      notifyListeners();
    }
  }
}
