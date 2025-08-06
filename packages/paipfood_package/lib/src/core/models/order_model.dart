import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:core/core.dart';

import 'package:paipfood_package/paipfood_package.dart';

enum OrderStatusEnum {
  greetingsMessage(ordeningIndex: 0, wppMessage: true, messageDefaut: 'wppGreetingsMessage', color: Colors.lightBlueAccent),
  pending(ordeningIndex: 1, wppMessage: true, messageDefaut: 'wppPending', color: Colors.yellow),
  accepted(ordeningIndex: 2, wppMessage: true, messageDefaut: 'wppAccepted', color: Colors.green),
  localOrderMessage(ordeningIndex: 3, wppMessage: true, messageDefaut: 'wppLocalOrderMessage', color: Colors.green),
  inDelivery(ordeningIndex: 4, wppMessage: true, messageDefaut: 'wppInDelivery', color: Colors.amber),
  awaitingPickup(ordeningIndex: 5, wppMessage: true, messageDefaut: 'wppAwaitingPickup', color: Colors.amber),
  delivered(ordeningIndex: 6, wppMessage: true, messageDefaut: 'wppDelivered', color: Colors.lime),
  canceled(ordeningIndex: 7, wppMessage: false, messageDefaut: 'wppCanceled', color: Colors.red),
  losted(ordeningIndex: 8, wppMessage: false, messageDefaut: 'wppLosted', color: Colors.black),
  awaitingDelivery(ordeningIndex: 9, wppMessage: true, messageDefaut: 'wppAwaitingDelivery', color: Colors.amber);

  final String messageDefaut;
  final Color color;
  final bool wppMessage;
  final int ordeningIndex;

  const OrderStatusEnum({required this.ordeningIndex, required this.wppMessage, required this.messageDefaut, required this.color});
  static OrderStatusEnum fromMap(String value) => OrderStatusEnum.values.firstWhere((element) => element.name == value);
}

class OrderModel {
  final String id;
  final DateTime? createdAt;
  final String establishmentId;
  final DateTime? updatedAt;
  final DateTime? acceptedDate;
  final DateTime? inDeliveryDate;
  final DateTime? deliveredDate;
  final DateTime? canceledDate;
  final CustomerModel customer;
  final List<CartProductDto> cartProducts;
  final double subTotal;
  final double amount;
  final double deliveryTax;
  final double tax;
  final double discount;
  final double changeTo;
  final String? deliveryAreaId;
  final int? orderNumber;
  final OrderTypeEnum? orderType;
  final String? userId;
  final OrderStatusEnum status;
  final DateTime? dateLimit;
  final double netTotal;
  final PaymentType? paymentType;
  final String? driverId;
  final DateTime? scheduleDate;
  final String? billId;
  final String? chargeId;
  final bool isLocal;
  final PaymentProvider? paymentProvider;
  final ChargeEntity? charge;

  OrderModel({
    required this.id,
    required this.establishmentId,
    required this.cartProducts,
    required this.customer,
    this.orderType = OrderTypeEnum.takeWay,
    this.paymentType,
    this.createdAt,
    this.updatedAt,
    this.acceptedDate,
    this.inDeliveryDate,
    this.deliveredDate,
    this.canceledDate,
    this.subTotal = 0.0,
    this.amount = 0.0,
    this.deliveryTax = 0.0,
    this.tax = 0.0,
    this.discount = 0.0,
    this.changeTo = 0.0,
    this.deliveryAreaId,
    this.orderNumber,
    this.userId,
    this.isLocal = false,
    this.dateLimit,
    this.netTotal = 0.0,
    this.driverId,
    this.scheduleDate,
    this.billId,
    this.chargeId,
    this.charge,
    this.status = OrderStatusEnum.pending,
    this.paymentProvider,
  });
  static const String box = 'orders';
  static const String boxList = 'orders_list';
  static const String boxReactivity = 'orders_reactivity';
  OrderModel copyWith({
    String? id,
    DateTime? createdAt,
    String? establishmentId,
    OrderTypeEnum? orderType,
    DateTime? updatedAt,
    DateTime? acceptedDate,
    DateTime? inDeliveryDate,
    DateTime? deliveredDate,
    DateTime? canceledDate,
    CustomerModel? customer,
    List<CartProductDto>? cartProducts,
    PaymentType? paymentType,
    double? subTotal,
    double? amount,
    double? deliveryTax,
    double? tax,
    double? discount,
    double? changeTo,
    String? deliveryAreaId,
    int? orderNumber,
    String? userId,
    bool? isLocal,
    DateTime? dateLimit,
    double? netTotal,
    String? driverId,
    DateTime? scheduleDate,
    String? billId,
    String? chargeId,
    ChargeEntity? charge,
    OrderStatusEnum? status,
    PaymentProvider? paymentProvider,
  }) {
    return OrderModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      establishmentId: establishmentId ?? this.establishmentId,
      orderType: orderType ?? this.orderType,
      updatedAt: updatedAt ?? this.updatedAt,
      acceptedDate: acceptedDate ?? this.acceptedDate,
      inDeliveryDate: inDeliveryDate ?? this.inDeliveryDate,
      deliveredDate: deliveredDate ?? this.deliveredDate,
      canceledDate: canceledDate ?? this.canceledDate,
      customer: customer ?? this.customer,
      cartProducts: cartProducts ?? this.cartProducts,
      paymentType: paymentType ?? this.paymentType,
      subTotal: subTotal ?? this.subTotal,
      amount: amount ?? this.amount,
      deliveryTax: deliveryTax ?? this.deliveryTax,
      tax: tax ?? this.tax,
      discount: discount ?? this.discount,
      changeTo: changeTo ?? this.changeTo,
      deliveryAreaId: deliveryAreaId ?? this.deliveryAreaId,
      orderNumber: orderNumber ?? this.orderNumber,
      userId: userId ?? this.userId,
      isLocal: isLocal ?? this.isLocal,
      dateLimit: dateLimit ?? this.dateLimit,
      netTotal: netTotal ?? this.netTotal,
      driverId: driverId ?? this.driverId,
      scheduleDate: scheduleDate ?? this.scheduleDate,
      billId: billId ?? this.billId,
      chargeId: chargeId ?? this.chargeId,
      charge: charge ?? this.charge,
      status: status ?? this.status,
      paymentProvider: paymentProvider ?? this.paymentProvider,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'establishment_id': establishmentId,
      'order_type': orderType?.name ?? OrderTypeEnum.takeWay.name,
      'updated_at': DateTime.now().pToTimesTamptzFormat(),
      'accepted_date': acceptedDate?.pToTimesTamptzFormat(),
      'in_delivery_date': inDeliveryDate?.pToTimesTamptzFormat(),
      'delivered_date': deliveredDate?.pToTimesTamptzFormat(),
      'canceled_date': canceledDate?.pToTimesTamptzFormat(),
      'customer': customer.toMap(),
      'cart_products': cartProducts.map((x) => x.toMap()).toList(),
      'payment_type': paymentType?.name,
      'sub_total': getSubTotal,
      'amount': getAmount,
      'delivery_tax': deliveryTax,
      'tax': tax,
      'discount': discount,
      'change_to': changeTo,
      'delivery_area_id': deliveryAreaId,
      'order_number': orderNumber == -1 ? null : orderNumber,
      'user_id': userId,
      'is_local': isLocal,
      'date_limit': dateLimit?.toIso8601String(),
      'net_total': netTotal,
      'driver_id': driverId,
      'schedule_date': scheduleDate?.pToTimesTamptzFormat(),
      'charge_id': chargeId,
      'status': status.name,
      'bill_id': billId,
      'payment_provider': paymentProvider?.name,
    };
  }

  factory OrderModel.fromMap(Map map) {
    return OrderModel(
      id: map['id'] ?? '',
      establishmentId: map['establishment_id'] ?? '',
      orderType: OrderTypeEnum.fromMap(map['order_type']),
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      acceptedDate: map['accepted_date'] != null ? DateTime.parse(map['accepted_date']) : null,
      inDeliveryDate: map['in_delivery_date'] != null ? DateTime.parse(map['in_delivery_date']) : null,
      deliveredDate: map['delivered_date'] != null ? DateTime.parse(map['delivered_date']) : null,
      canceledDate: map['canceled_date'] != null ? DateTime.parse(map['canceled_date']) : null,
      customer: CustomerModel.fromMap(map['customer']),
      cartProducts: List<CartProductDto>.from(map['cart_products']?.map((x) => CartProductDto.fromMap(x)) ?? const []),
      paymentType: map['payment_type'] != null ? PaymentType.fromMap(map['payment_type']) : null,
      subTotal: map['sub_total']?.toDouble() ?? 0.0,
      amount: map['amount']?.toDouble() ?? 0.0,
      deliveryTax: map['delivery_tax']?.toDouble() ?? 0.0,
      tax: map['tax']?.toDouble() ?? 0.0,
      discount: map['discount']?.toDouble() ?? 0.0,
      changeTo: map['change_to']?.toDouble(),
      deliveryAreaId: map['delivery_area_id'],
      orderNumber: map['order_number']?.toInt(),
      userId: map['user_id'],
      isLocal: map['is_local'] ?? false,
      dateLimit: map['date_limit'] != null ? DateTime.parse(map['date_limit']) : null,
      netTotal: map['net_total']?.toDouble(),
      driverId: map['driver_id'],
      scheduleDate: map['schedule_date'] != null ? DateTime.parse(map['schedule_date']) : null,
      billId: map['bill_id'],
      chargeId: map['charge_id'],
      status: OrderStatusEnum.fromMap(map['status']),
      charge: map['charge'] != null ? ChargeEntity.fromMap(map['charge']) : null,
      paymentProvider: map['payment_provider'] != null ? PaymentProvider.fromMap(map['payment_provider']) : null,
    );
  }

  factory OrderModel.empty() => OrderModel(id: uuid, establishmentId: '', cartProducts: [], customer: CustomerModel(addresses: []));

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source));

  double get getCartAmount => cartProducts.fold(0.0, (previousValue, element) => previousValue + element.amount);
  double get getSubTotal {
    double total = 0.0;
    total += getCartAmount;
    if (orderType == OrderTypeEnum.delivery) total += deliveryTax;
    return total;
  }

  bool get isAvailable {
    if (chargeId == null && paymentProvider == null) return true;
    if (chargeId != null && charge != null && charge!.status != ChargeStatus.pending) return true;
    return false;
  }

  bool get expired {
    if (dateLimit == null) return true;
    final now = DateTime.now().pNormalizeToCondition();
    final limit = dateLimit!.pNormalizeToCondition();

    final bool result = now.isAfter(limit);
    return result;
  }

  String get createdAtFormated => DateFormat('').add_jm().format(createdAt?.toLocal() ?? DateTime.now().toLocal());
  String get orderTimeFormated => DateFormat('').add_jm().format(scheduleDate?.toLocal() ?? DateTime.now().toLocal());
  String get createdAtFormatedDateHour => DateFormat('dd/MM/yyyy -').add_jm().format(createdAt?.toLocal() ?? DateTime.now());
  double get getAmount => getSubTotal - discount;
  double get getChange => changeTo - getAmount;
  String get getResume => "";
  String get getOrderNumber => _buildOrderNumber();

  String _buildOrderNumber() {
    if (isLocal) {
      return "${customer.name.substring(0, 1).toUpperCase()}${((orderNumber ?? 0) > 9) ? orderNumber.toString() : "0$orderNumber"}";
    }

    return ((orderNumber ?? 0) > 9) ? orderNumber.toString() : "0$orderNumber";
  }

  String? get timeLimitFormated {
    final DateTime now = DateTime.now();
    final DateTime dateLimit = Utils.dateParseToNow(this.dateLimit!); // Convertendo para o fuso horário local
    final difference = dateLimit.difference(now); // Calculando a diferença entre as datas
    if (difference.inMicroseconds < 0) return null;
    final minutes = difference.inMinutes;
    final seconds = difference.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  String buildScheduleTimeIntervalFormated(BuildContext context) {
    if (scheduleDiferenceInDays() > 1) return buildScheduleTimeFormated(context);
    // return "${buildScheduleTimeFormated(context)} - ${scheduleDate?.add(10.minutes).pFactoryCountryFormatHHmm()}";
    return "";
  }

  int scheduleDiferenceInDays() {
    final DateTime now = DateTime.now();
    final DateTime schedule = scheduleDate!.pNormalizeToCondition();
    return schedule.copyWith(hour: 0, minute: 0, second: 0).difference(now.copyWith(hour: 0, minute: 0, second: 0)).inDays;
  }

  String buildScheduleTimeFormated(BuildContext context) {
    if (isNotScheduling) return "";
    final DateTime schedule = scheduleDate!.pNormalizeToCondition();
    final int daysDifference = scheduleDiferenceInDays();
    // final hourSufix = " ${scheduleDate!.pFactoryCountryFormatHHmm()}";
    // if (daysDifference == -1) return context.i18nCore.ontem + hourSufix;
    // if (daysDifference == 0) return context.i18nCore.hoje + hourSufix;
    // if (daysDifference == 1) return context.i18nCore.amanha + hourSufix;
    // return schedule.pFactoryCountryFormatDDMMYYHHmm();
    return "";
  }

  bool get isScheduling => scheduleDate != null;
  bool get isNotScheduling => !isScheduling;

  bool get schedulingAllowNextStatus {
    if ((status == OrderStatusEnum.pending) || isNotScheduling) return true;
    final now = DateTime.now();
    final schedule = scheduleDate!.subtract(12.hours).pNormalizeToCondition();
    if (now.isAfter(schedule)) return true;
    return false;
  }

  bool get dontSchedulingAllowNextStatus => !schedulingAllowNextStatus;
  static final int _paymeTimeLimitInMinutes = 5;

  bool get isPaymentStatusAvaliable => DateTime.now().add(_paymeTimeLimitInMinutes.minutes).isAfter(createdAt?.pNormalizeToCondition() ?? DateTime.now().subtract(6.minutes));
  bool get isNotPaymentStatusAvaliable => !isPaymentStatusAvaliable;

  String get regressivePaymentTimeCounterFormatted {
    final now = DateTime.now();
    final endTime = createdAt?.add(Duration(minutes: _paymeTimeLimitInMinutes, seconds: 15)) ?? now;
    final difference = endTime.difference(now);

    if (difference.isNegative) return "0:00";

    final minutes = difference.inMinutes;
    final seconds = difference.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
