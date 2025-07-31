import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:manager/l10n/l10n_provider.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/helpers/assets.dart';
import 'package:manager/src/core/stores/bills_store.dart';
import 'package:manager/src/core/stores/orders_store.dart';
import 'package:manager/src/core/usecases/upsert_local_customer_usecase.dart';
import 'package:manager/src/modules/chatbot/domain/usecases/chatbot_wpp_messages_usecase.dart';
import 'package:manager/src/modules/config/aplication/usecases/update_establishment_usecase.dart';
import 'package:manager/src/modules/config/presenters/viewmodels/printer_viewmodel.dart';
import 'package:manager/src/modules/config/presenters/viewmodels/user_preferences_viewmode.dart';
import 'package:manager/src/modules/order/aplication/usecases/cancel_order_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/get_orders_usecase.dart';

import 'package:manager/src/modules/order/aplication/usecases/set_driver_to_order_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/upsert_order_usecase.dart';

import 'package:paipfood_package/paipfood_package.dart';

class OrderStore extends ChangeNotifier {
  final IOrderRepository orderRepo;
  final DataSource dataSource;
  final GetOrdersUsecase getOrdersUsecase;
  final ChatbotWppMessagesUsecase wppService;
  final CancelOrderUsecase cancelOrderUsecase;
  final PrinterViewmodel printerViewmodel;
  final UpdateEstablishmentUsecase updateEstablishmentUsecase;
  final UpsertOrderUsecase updateOrderUsecase;
  final SetDriverToOrderUsecase setDriverToOrderUsecase;
  final UpsertLocalCustomerUsecase upsertLocalCustomerUsecase;
  final UserPreferencesViewmodel userPreferencesViewmodel;

  // Map para controlar pedidos já impressos
  final Map<String, DateTime> _printedOrders = {};

  OrderStore({
    required this.orderRepo,
    required this.dataSource,
    required this.getOrdersUsecase,
    required this.wppService,
    required this.cancelOrderUsecase,
    required this.printerViewmodel,
    required this.updateEstablishmentUsecase,
    required this.updateOrderUsecase,
    required this.setDriverToOrderUsecase,
    required this.upsertLocalCustomerUsecase,
    required this.userPreferencesViewmodel,
  });
  bool isLoad = false;

  bool get isPrimaryTerminal => userPreferencesViewmodel.userPreferences.isPrimaryTerminal;

  EstablishmentModel get establishment => establishmentProvider.value;

  DriverAndUserAdapter? getDriver(OrderModel order) {
    return dataSource.deliveryMen[order.driverId];
  }

  List<DriverAndUserAdapter> get getDeliveryMen => dataSource.deliveryMen.values.where((element) => element.isAccepted).toList();

  DriverAndUserAdapter? get connectDeliveryMen => dataSource.connectDeliveryMen;

  List<OrderModel> get orders => OrdersStore.instance.orders;

  AudioPlayer? player;
  var rebuilPedings = ValueNotifier(0);
  var rebuildAccepteds = ValueNotifier(0);
  var rebuildInDeliveries = ValueNotifier(0);
  var rebuildDelivereds = ValueNotifier(0);
  var rebuildCanceleds = ValueNotifier(0);
  var rebuildLosteds = ValueNotifier(0);

  Map<String, OrderModel> pedings = {};
  Map<String, OrderModel> accepteds = {};
  Map<String, OrderModel> inDeliveries = {};
  Map<String, OrderModel> delivereds = {};
  Map<String, OrderModel> canceleds = {};
  Map<String, OrderModel> losteds = {};

  Map<String, OrderModel> get _pedings => Map.fromEntries(orders.where((order) => order.status == OrderStatusEnum.pending).map((order) => MapEntry(order.id, order)).toList());

  Map<String, OrderModel> get _accepteds => Map.fromEntries(orders.where((order) => order.status == OrderStatusEnum.accepted).map((order) => MapEntry(order.id, order)).toList());

  Map<String, OrderModel> get _inDelivery =>
      Map.fromEntries(orders.where((entry) => entry.status == OrderStatusEnum.inDelivery || entry.status == OrderStatusEnum.awaitingPickup || entry.status == OrderStatusEnum.awaitingDelivery).map((order) => MapEntry(order.id, order)).toList());

  Map<String, OrderModel> get _delivereds => Map.fromEntries(orders.where((order) => order.status == OrderStatusEnum.delivered).map((order) => MapEntry(order.id, order)).toList());

  Map<String, OrderModel> get _cancelds => Map.fromEntries(orders.where((order) => order.status == OrderStatusEnum.canceled).map((order) => MapEntry(order.id, order)).toList());

  Map<String, OrderModel> get _losteds => Map.fromEntries(orders.where((order) => order.status == OrderStatusEnum.losted).map((order) => MapEntry(order.id, order)).toList());

  Future<bool> init() async {
    if (isLoad) return true;
    await getOrdersUsecase.call();
    refreshOrders();
    _syncPrintedOrders();
    isLoad = true;
    return true;
  }

  void removeOrderLists(String id) {
    pedings.remove(id);
    accepteds.remove(id);
    inDeliveries.remove(id);
    delivereds.remove(id);
    canceleds.remove(id);
    losteds.remove(id);
  }

  BillModel? getBill(OrderModel order) {
    if (order.billId == null) return null;
    final bill = BillsStore.instance.getBillById(order.billId!);
    return bill;
  }

  void updateOderInList(OrderModel order) {
    final status = order.status;
    final result = switch (status) {
      OrderStatusEnum.pending => () {
          _pedings[order.id] = order;
          pedings[order.id] = order;
          rebuilPedings.value++;
        },
      OrderStatusEnum.accepted => () {
          _accepteds[order.id] = order;
          accepteds[order.id] = order;
          rebuildAccepteds.value++;
        },
      OrderStatusEnum.inDelivery || OrderStatusEnum.awaitingPickup || OrderStatusEnum.awaitingDelivery => () {
          _inDelivery[order.id] = order;
          inDeliveries[order.id] = order;
          rebuildInDeliveries.value++;
        },
      OrderStatusEnum.delivered => () {
          _delivereds[order.id] = order;
          delivereds[order.id] = order;
          rebuildDelivereds.value++;
        },
      OrderStatusEnum.canceled => () {
          _cancelds[order.id] = order;
          canceleds[order.id] = order;
          rebuildCanceleds.value++;
        },
      OrderStatusEnum.losted => () {
          _losteds[order.id] = order;
          losteds[order.id] = order;
          rebuildLosteds.value++;
        },
      _ => () {},
    };

    result.call();
  }

  void refreshOrders() {
    pedings = _pedings;
    accepteds = _accepteds;
    inDeliveries = _inDelivery;
    delivereds = _delivereds;
    canceleds = _cancelds;
    losteds = _losteds;
    _syncPrintedOrders();
  }

  /// Sincroniza o Map de pedidos impressos com os pedidos aceitos atuais
  void _syncPrintedOrders() {
    for (final order in orders.where((order) => order.status != OrderStatusEnum.pending)) {
      _printedOrders[order.id] = DateTime.now();
    }
  }

  Future<void> playSound() async {
    if (player != null) return;
    player = AudioPlayer();
    await Future.delayed(100.ms);
    while (pedings.isNotEmpty) {
      await player!.play(AssetSource(PSounds.alert), volume: 1);
      await player!.onPlayerComplete.first;
    }

    if (pedings.isEmpty) {
      await player!.stop();
      await player!.dispose();
      player = null;
    }
  }

  int calculateIndexOrder(int index) {
    if (index == 0) return index;
    return index - 1;
  }

  Future<void> cancelOrder({required OrderModel order, required String message}) async {
    removeOrderLists(order.id);
    await cancelOrderUsecase.call(order: order, establishment: establishment, message: message);
    await upsertLocalCustomerUsecase.call(customer: order.customer, increment: false);
    // TODO: @EDUARDO - Implementar o REFOUND
    toast.showInfo(l10nProiver.pedidoCancelado);
  }

  Future<void> addOrderToList(OrderModel order) async {
    await _removeOrderAncestor(orderStatus: order.status, order: order);
    if (order.status == OrderStatusEnum.pending) {
      pedings.addEntries([MapEntry(order.id, order)]);
      rebuilPedings.value++;
      if (establishment.automaticAcceptOrders && isPrimaryTerminal) {
        Future.delayed(2.seconds, () async => await nextStatus(order: order));
      }
      await playSound();
      return;
    }
    if (isPrimaryTerminal) unawaited(wppService.sendMessageByOrderStatus(order: order, phone: order.customer.getPhoneOnlyNumber));
    if (order.status == OrderStatusEnum.accepted) {
      if (isPrimaryTerminal) {
        try {
          final wasPrinted = _printedOrders.containsKey(order.id);

          if (!wasPrinted && printerViewmodel.printersInUse.isNotEmpty) {
            await printerViewmodel.printOrder(order: order);
            _printedOrders[order.id] = DateTime.now();
          }
        } catch (_) {}
      }
      accepteds.addEntries([MapEntry(order.id, order)]);
      rebuildAccepteds.value++;
      await _upsertCustomer(order.customer);
      return;
    }
    // send message wpp
    if (order.status == OrderStatusEnum.inDelivery || order.status == OrderStatusEnum.awaitingPickup || order.status == OrderStatusEnum.awaitingDelivery) {
      inDeliveries.addEntries([MapEntry(order.id, order)]);
      rebuildInDeliveries.value++;
      return;
    }
    if (order.status == OrderStatusEnum.delivered) {
      if (isPrimaryTerminal) {
        delivereds.addEntries([MapEntry(order.id, order)]);
      }

      rebuildDelivereds.value++;
      return;
    }
    if (order.status == OrderStatusEnum.canceled) {
      refreshOrders();
      Future.delayed(500.milliseconds, () {
        notifyListeners();
      });
    }
    if (order.status == OrderStatusEnum.losted) {
      refreshOrders();
      Future.delayed(500.milliseconds, () {
        notifyListeners();
      });
    }
  }

  Future<void> nextStatus({required OrderModel order}) async {
    final OrderStatusEnum statusDelivery = switch (order.status) {
      OrderStatusEnum.pending => OrderStatusEnum.accepted,
      OrderStatusEnum.accepted => OrderStatusEnum.awaitingDelivery,
      OrderStatusEnum.awaitingDelivery => OrderStatusEnum.inDelivery,
      OrderStatusEnum.inDelivery => OrderStatusEnum.delivered,
      _ => OrderStatusEnum.accepted,
    };
    final statusPickup = switch (order.status) {
      OrderStatusEnum.pending => OrderStatusEnum.accepted,
      OrderStatusEnum.accepted => OrderStatusEnum.awaitingPickup,
      OrderStatusEnum.awaitingPickup => OrderStatusEnum.delivered,
      OrderStatusEnum.inDelivery => OrderStatusEnum.delivered,
      _ => OrderStatusEnum.accepted,
    };

    order = order.copyWith(status: (order.orderType == OrderTypeEnum.delivery) ? statusDelivery : statusPickup);
    order = _nextStatusDate(order: order, orderStatus: order.status);
    await _removeOrderAncestor(orderStatus: order.status, order: order);
    await updateOrderUsecase.call(order: order);
  }

  OrderModel _nextStatusDate({required OrderModel order, required OrderStatusEnum orderStatus}) {
    final now = DateTime.now();
    if (orderStatus == OrderStatusEnum.canceled || orderStatus == OrderStatusEnum.losted) return order.copyWith(canceledDate: now);
    if (orderStatus == OrderStatusEnum.accepted) return order.copyWith(acceptedDate: now);
    if (orderStatus == OrderStatusEnum.awaitingPickup || orderStatus == OrderStatusEnum.awaitingDelivery) return order.copyWith(inDeliveryDate: now);
    return order.copyWith(deliveredDate: now);
  }

  Future<void> _removeOrderAncestor({required OrderStatusEnum orderStatus, required OrderModel order}) async {
    if (orderStatus == OrderStatusEnum.accepted) {
      pedings.remove(order.id);
      await Future.delayed(100.milliseconds, () => rebuilPedings.value++);
    }
    if (orderStatus == OrderStatusEnum.inDelivery || orderStatus == OrderStatusEnum.awaitingPickup || orderStatus == OrderStatusEnum.awaitingDelivery) {
      accepteds.remove(order.id);
      Future.delayed(100.milliseconds, () => rebuildAccepteds.value++);
    }
    if (orderStatus == OrderStatusEnum.delivered) {
      inDeliveries.remove(order.id);
      Future.delayed(100.milliseconds, () => rebuildInDeliveries.value++);
    }
  }

  void setDeliveryTime({String? initialTime, String? endTime}) {
    String init = establishmentProvider.value.getTimesDelivery[0];
    String end = establishmentProvider.value.getTimesDelivery[1];
    if (initialTime != null) {
      init = initialTime;
    }
    if (endTime != null) {
      end = endTime;
    }
    establishmentProvider.value.timeDelivery = "$init|$end";
  }

  void setTakewayTime({String? initialTime, String? endTime}) {
    String init = establishmentProvider.value.getTimesTakeway[0];
    String end = establishmentProvider.value.getTimesTakeway[1];
    if (initialTime != null) {
      init = initialTime;
    }
    if (endTime != null) {
      end = endTime;
    }
    establishmentProvider.value.timeTakeway = "$init|$end";
  }

  Future<void> updateEstablishment() async {
    await updateEstablishmentUsecase.call();
    toast.showSucess(l10nProiver.salvo);
  }

  Future<void> setDriverToOrder({required OrderModel order, required DriverAndUserAdapter driver}) async {
    order = order.copyWith(driverId: driver.driver.userId);
    await setDriverToOrderUsecase.call(order: order, driver: driver);
  }

  Future<void> _upsertCustomer(CustomerModel customer) async {
    customer = customer.copyWith(lastOrderAt: DateTime.now());
    await upsertLocalCustomerUsecase.call(customer: customer, increment: true);
  }
}
