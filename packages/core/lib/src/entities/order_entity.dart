import 'package:core/src/metadatas/customer_metadata.dart';

class OrderEntity {
  final String id;
  final DateTime createdAt;
  final String? establishmentId;
  final DateTime? updatedAt;
  final DateTime? acceptedDate;
  final DateTime? inDeliveryDate;
  final DateTime? deliveredDate;
  final DateTime? canceledDate;
  final CustomerMetadata customer;
  final Map<String, dynamic>? cartProducts;
  final double? subTotal;
  final double? amount;
  final double? deliveryTax;
  final double? tax;
  final double? discount;
  final double? changeTo;
  final String? deliveryAreaId;
  final int? orderNumber;
  final String orderType;
  final String? userId;
  final String orderStatus;
  final DateTime? dateLimit;
  final double netTotal;
  final String paymentType;
  final String? driverId;
  final DateTime? scheduleDate;
  final String? billId;
  final String? chargeId;

  OrderEntity({
    required this.id,
    required this.createdAt,
    required this.establishmentId,
    required this.updatedAt,
    required this.acceptedDate,
    required this.inDeliveryDate,
    required this.deliveredDate,
    required this.canceledDate,
    required this.customer,
    required this.cartProducts,
    required this.subTotal,
    required this.amount,
    required this.deliveryTax,
    required this.tax,
    required this.discount,
    required this.changeTo,
    required this.deliveryAreaId,
    required this.orderNumber,
    required this.orderType,
    required this.userId,
    required this.orderStatus,
    required this.dateLimit,
    required this.netTotal,
    required this.paymentType,
    required this.driverId,
    required this.scheduleDate,
    required this.billId,
    required this.chargeId,
  });
}
