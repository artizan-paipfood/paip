import 'dart:convert';
import 'package:core/core.dart';

class OrderSplitWithPaymentProviderView {
  final String id;
  final double? deliveryTax;
  final String? driverId;
  final String establishmentId;
  final String orderType;
  final String orderStatus;
  final double netTotal;
  final PaymentType paymentType;
  final DateTime? scheduleDate;
  final PaymentProvider? paymentProvider;
  final FranchiseEntity? franchise;
  final PaymentProviderView? franchisePaymentProvider;
  final PaymentProviderView? establishmentPaymentProvider;
  final PaymentProviderView? driverPaymentProvider;
  OrderSplitWithPaymentProviderView({
    required this.id,
    this.deliveryTax,
    this.driverId,
    required this.establishmentId,
    required this.orderType,
    required this.orderStatus,
    required this.netTotal,
    required this.paymentType,
    this.scheduleDate,
    this.paymentProvider,
    this.franchise,
    this.franchisePaymentProvider,
    this.establishmentPaymentProvider,
    this.driverPaymentProvider,
  });

  static const String view = 'view_order_process_with_payment_provider';

  OrderSplitWithPaymentProviderView copyWith({
    String? id,
    double? deliveryTax,
    String? driverId,
    String? establishmentId,
    String? orderType,
    String? orderStatus,
    double? netTotal,
    PaymentType? paymentType,
    DateTime? scheduleDate,
    PaymentProvider? paymentProvider,
    FranchiseEntity? franchise,
    PaymentProviderView? franchisePaymentProvider,
    PaymentProviderView? establishmentPaymentProvider,
    PaymentProviderView? driverPaymentProvider,
  }) {
    return OrderSplitWithPaymentProviderView(
      id: id ?? this.id,
      deliveryTax: deliveryTax ?? this.deliveryTax,
      driverId: driverId ?? this.driverId,
      establishmentId: establishmentId ?? this.establishmentId,
      orderType: orderType ?? this.orderType,
      orderStatus: orderStatus ?? this.orderStatus,
      netTotal: netTotal ?? this.netTotal,
      paymentType: paymentType ?? this.paymentType,
      scheduleDate: scheduleDate ?? this.scheduleDate,
      paymentProvider: paymentProvider ?? this.paymentProvider,
      franchise: franchise ?? this.franchise,
      franchisePaymentProvider: franchisePaymentProvider ?? this.franchisePaymentProvider,
      establishmentPaymentProvider: establishmentPaymentProvider ?? this.establishmentPaymentProvider,
      driverPaymentProvider: driverPaymentProvider ?? this.driverPaymentProvider,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'delivery_tax': deliveryTax,
      'driver_id': driverId,
      'establishment_id': establishmentId,
      'order_type': orderType,
      'order_status': orderStatus,
      'net_total': netTotal,
      'payment_type': paymentType.name,
      'schedule_date': scheduleDate?.toPaipDB(),
      'payment_provider': paymentProvider?.name,
      'franchise': franchise?.toMap(),
      'franchise_payment_provider': franchisePaymentProvider?.toMap(),
      'establishment_payment_provider': establishmentPaymentProvider?.toMap(),
      'driver_payment_provider': driverPaymentProvider?.toMap(),
    };
  }

  factory OrderSplitWithPaymentProviderView.fromMap(Map<String, dynamic> map) {
    return OrderSplitWithPaymentProviderView(
      id: map['id'] ?? '',
      deliveryTax: map['delivery_tax']?.toDouble(),
      driverId: map['driver_id'],
      establishmentId: map['establishment_id'] ?? '',
      orderType: map['order_type'] ?? '',
      orderStatus: map['order_status'] ?? '',
      netTotal: map['net_total']?.toDouble() ?? 0.0,
      paymentType: PaymentType.fromMap(map['payment_type']),
      scheduleDate: map['schedule_date'] != null ? DateTime.parse(map['schedule_date']) : null,
      paymentProvider: map['payment_provider'] != null ? PaymentProvider.fromMap(map['payment_provider']) : null,
      franchise: map['franchise'] != null ? FranchiseEntity.fromMap(map['franchise']) : null,
      franchisePaymentProvider: map['franchise_payment_provider'] != null ? PaymentProviderView.fromMap(map['franchise_payment_provider']) : null,
      establishmentPaymentProvider: map['establishment_payment_provider'] != null ? PaymentProviderView.fromMap(map['establishment_payment_provider']) : null,
      driverPaymentProvider: map['driver_payment_provider'] != null ? PaymentProviderView.fromMap(map['driver_payment_provider']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderSplitWithPaymentProviderView.fromJson(String source) => OrderSplitWithPaymentProviderView.fromMap(json.decode(source));
}
