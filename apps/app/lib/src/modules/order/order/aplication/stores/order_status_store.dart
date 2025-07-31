import 'package:flutter/material.dart';
import 'package:app/src/modules/menu/domain/usecases/upsert_order_usecase.dart';
import 'package:app/src/modules/order/order/aplication/usecases/order_usecase.dart';
import 'package:app/src/modules/order/order/domain/dtos/order_and_establishment_dto.dart';
import 'package:paipfood_package/paipfood_package.dart';

class OrderStatusStore extends ChangeNotifier {
  final OrderUsecase orderUsecase;
  final UpsertOrderUsecase updateOrderUsecase;
  OrderStatusStore({
    required this.updateOrderUsecase,
    required this.orderUsecase,
  });

  //$ VARIABLES
  DateTime? dateLimit;
  var currentSetEP = ValueNotifier(0);
  OrderAndEstablishmentDto? orderAndEstablishmentDto;

  bool get needUpdate => DateTime.now().isAfter(dateLimit ?? DateTime.now());

  //$ GETTERS AND SETTERS
  EstablishmentModel get establishment => orderAndEstablishmentDto!.establishment;
  OrderModel get order => orderAndEstablishmentDto!.order;
  CustomerModel get customer => order.customer;

  //$ METHODS

  Future<bool> init(String orderId) async {
    if (dateLimit != null && !needUpdate) return true;
    orderAndEstablishmentDto = await orderUsecase.loadDto(orderId);
    verifyStepOrder();
    _verifyOrderStatus();
    dateLimit = DateTime.now().add(10.minutes);

    return true;
  }

  Future<void> updateOrder() async {
    final result = await orderUsecase.loadOrder(order.id);
    orderAndEstablishmentDto = orderAndEstablishmentDto!.copyWith(order: result);
    verifyStepOrder();
    notifyListeners();
  }

  void _verifyOrderStatus() async {
    while (order.status == OrderStatusEnum.pending && DateTime.now().isBefore(order.dateLimit!.pNormalizeToCondition())) {
      await updateOrder();
      await Future.delayed(15.seconds);
    }
  }

  verifyStepOrder() {
    currentSetEP.value =
        switch (order.status) { OrderStatusEnum.losted => -1, OrderStatusEnum.canceled => -1, OrderStatusEnum.pending => 0, OrderStatusEnum.accepted => 1, OrderStatusEnum.inDelivery => 2, OrderStatusEnum.awaitingPickup => 2, OrderStatusEnum.delivered => 3, _ => -1 };
  }
}
