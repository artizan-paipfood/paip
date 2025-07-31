import 'dart:convert';

import 'package:paipfood_package/paipfood_package.dart';

class WaiterOrderModel {
  String orderNumber;
  String customerId;
  String customerName;
  String customerAddress;

  String customerPhoneNumber;
  double deliveryLatitude;
  double deliveryLongitude;

  String restaurantId;
  String restaurantStatus;

  String expectedDeliveryDate;
  String expectedPickupTime;
  String expectedDeliveryTime;

  String paymentMethod;
  int totalOrderCost;
  int deliveryFee;
  int tips;
  int tax;
  int discountAmount;
  DateTime? orderTime;

  WaiterOrderModel({
    required this.orderNumber,
    required this.customerId,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhoneNumber,
    required this.deliveryLatitude,
    required this.deliveryLongitude,
    required this.restaurantId,
    required this.restaurantStatus,
    required this.expectedDeliveryDate,
    required this.expectedPickupTime,
    required this.expectedDeliveryTime,
    required this.paymentMethod,
    required this.totalOrderCost,
    required this.deliveryFee,
    required this.tips,
    required this.tax,
    required this.discountAmount,
    this.orderTime,
  });

  WaiterOrderModel copyWith({
    String? orderNumber,
    String? customerId,
    String? customerName,
    String? customerAddress,
    String? customerPhoneNumber,
    double? deliveryLatitude,
    double? deliveryLongitude,
    String? restaurantId,
    String? restaurantStatus,
    String? expectedDeliveryDate,
    String? expectedPickupTime,
    String? expectedDeliveryTime,
    String? paymentMethod,
    int? totalOrderCost,
    int? deliveryFee,
    int? tips,
    int? tax,
    int? discountAmount,
    DateTime? orderTime,
  }) {
    return WaiterOrderModel(
      orderNumber: orderNumber ?? this.orderNumber,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerAddress: customerAddress ?? this.customerAddress,
      customerPhoneNumber: customerPhoneNumber ?? this.customerPhoneNumber,
      deliveryLatitude: deliveryLatitude ?? this.deliveryLatitude,
      deliveryLongitude: deliveryLongitude ?? this.deliveryLongitude,
      restaurantId: restaurantId ?? this.restaurantId,
      restaurantStatus: restaurantStatus ?? this.restaurantStatus,
      expectedDeliveryDate: expectedDeliveryDate ?? this.expectedDeliveryDate,
      expectedPickupTime: expectedPickupTime ?? this.expectedPickupTime,
      expectedDeliveryTime: expectedDeliveryTime ?? this.expectedDeliveryTime,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalOrderCost: totalOrderCost ?? this.totalOrderCost,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      tips: tips ?? this.tips,
      tax: tax ?? this.tax,
      discountAmount: discountAmount ?? this.discountAmount,
      orderTime: orderTime ?? this.orderTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderNumber': orderNumber,
      'customerId': customerId,
      'customerName': customerName,
      'customerAddress': customerAddress,
      'customerPhoneNumber': customerPhoneNumber,
      'deliveryLatitude': deliveryLatitude,
      'deliveryLongitude': deliveryLongitude,
      'restaurantId': restaurantId,
      'restaurantStatus': restaurantStatus,
      'expectedDeliveryDate': expectedDeliveryDate,
      'expectedPickupTime': expectedPickupTime,
      'expectedDeliveryTime': expectedDeliveryTime,
      'paymentMethod': paymentMethod,
      'totalOrderCost': totalOrderCost,
      'deliveryFee': deliveryFee,
      'tips': tips,
      'tax': tax,
      'discountAmount': discountAmount,
      'orderTime': orderTime?.pToTimesTamptzFormat(),
    };
  }

  factory WaiterOrderModel.fromMap(Map<String, dynamic> map) {
    return WaiterOrderModel(
      orderNumber: map['orderNumber'] ?? '',
      customerId: map['customerId'] ?? '',
      customerName: map['customerName'] ?? '',
      customerAddress: map['customerAddress'] ?? '',
      customerPhoneNumber: map['customerPhoneNumber'] ?? '',
      deliveryLatitude: map['deliveryLatitude']?.toDouble() ?? 0.0,
      deliveryLongitude: map['deliveryLongitude']?.toDouble() ?? 0.0,
      restaurantId: map['restaurantId'] ?? '',
      restaurantStatus: map['restaurantStatus'] ?? '',
      expectedDeliveryDate: map['expectedDeliveryDate'] ?? '',
      expectedPickupTime: map['expectedPickupTime'] ?? '',
      expectedDeliveryTime: map['expectedDeliveryTime'] ?? '',
      paymentMethod: map['paymentMethod'] ?? '',
      totalOrderCost: map['totalOrderCost']?.toInt() ?? 0,
      deliveryFee: map['deliveryFee']?.toInt() ?? 0,
      tips: map['tips']?.toInt() ?? 0,
      tax: map['tax']?.toInt() ?? 0,
      discountAmount: map['discountAmount']?.toInt() ?? 0,
      orderTime: map['orderTime'] != null ? DateTime.parse(map['orderTime']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WaiterOrderModel.fromJson(String source) => WaiterOrderModel.fromMap(json.decode(source));

  static WaiterOrderModel fromOrderModel({required OrderModel order}) => WaiterOrderModel(
      orderNumber: order.id,
      customerId: order.customer.userId!,
      customerName: order.customer.name,
      customerAddress: order.customer.address!.formattedAddress(LocaleNotifier.instance.locale),
      customerPhoneNumber: order.customer.phone,
      deliveryLatitude: order.customer.address!.lat!,
      deliveryLongitude: order.customer.address!.long!,
      restaurantId: order.establishmentId,
      restaurantStatus: order.status.name,
      expectedDeliveryDate: order.createdAt!.toIso8601String(),
      expectedPickupTime: order.createdAt!.add(const Duration(minutes: 20)).toIso8601String(),
      expectedDeliveryTime: order.createdAt!.add(const Duration(minutes: 40)).toIso8601String(),
      //TODO: @SergioColetto favor reavaliar
      paymentMethod: order.paymentType?.name ?? '',
      totalOrderCost: (order.amount * 100).toInt(),
      deliveryFee: (order.deliveryTax * 100).toInt(),
      tips: 0,
      tax: 0,
      discountAmount: 0,
      orderTime: order.scheduleDate);

  @override
  String toString() {
    return 'WaiterOrderModel(orderNumber: $orderNumber, customerId: $customerId, customerName: $customerName, customerAddress: $customerAddress, customerPhoneNumber: $customerPhoneNumber, deliveryLatitude: $deliveryLatitude, deliveryLongitude: $deliveryLongitude, restaurantId: $restaurantId, expectedDeliveryDate: $expectedDeliveryDate, expectedPickupTime: $expectedPickupTime, expectedDeliveryTime: $expectedDeliveryTime, paymentMethod: $paymentMethod, totalOrderCost: $totalOrderCost, deliveryFee: $deliveryFee, tips: $tips, tax: $tax, discountAmount: $discountAmount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WaiterOrderModel &&
        other.orderNumber == orderNumber &&
        other.customerId == customerId &&
        other.customerName == customerName &&
        other.customerAddress == customerAddress &&
        other.customerPhoneNumber == customerPhoneNumber &&
        other.deliveryLatitude == deliveryLatitude &&
        other.deliveryLongitude == deliveryLongitude &&
        other.restaurantId == restaurantId &&
        other.expectedDeliveryDate == expectedDeliveryDate &&
        other.expectedPickupTime == expectedPickupTime &&
        other.expectedDeliveryTime == expectedDeliveryTime &&
        other.paymentMethod == paymentMethod &&
        other.totalOrderCost == totalOrderCost &&
        other.deliveryFee == deliveryFee &&
        other.tips == tips &&
        other.tax == tax;
  }

  @override
  int get hashCode {
    return orderNumber.hashCode ^
        customerId.hashCode ^
        customerName.hashCode ^
        customerAddress.hashCode ^
        customerPhoneNumber.hashCode ^
        deliveryLatitude.hashCode ^
        deliveryLongitude.hashCode ^
        restaurantId.hashCode ^
        expectedDeliveryDate.hashCode ^
        expectedPickupTime.hashCode ^
        expectedDeliveryTime.hashCode ^
        paymentMethod.hashCode ^
        totalOrderCost.hashCode ^
        deliveryFee.hashCode ^
        tips.hashCode ^
        tax.hashCode;
  }
}
