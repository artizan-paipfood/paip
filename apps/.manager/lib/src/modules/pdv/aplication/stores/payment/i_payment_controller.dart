import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:manager/src/modules/pdv/domain/payment_pdv_dto.dart';
import 'package:paipfood_package/paipfood_package.dart';

abstract class IPaymentController extends ChangeNotifier {
  double get total;
  double get subTotal;
  double get totalPayments;
  double get discount;
  double get changeTo;
  double get serviceTax;
  double get remainingTotal;
  double get deliveryTax;
  List<OrderModel> get orders;

  List<PaymentDto> get payments;

  PaymentType get paymentType;

  List<PaymentType> get paymentMethodsAvaliable;

  Future<void> initialize(PaymentPdvDto dto);

  void reset();

  Future<void> finish();

  void notify();

  /// retorna true se foi finalizado
  Future<bool> onPay({required double value, required PaymentType paymentType, required String observation});

  Future<void> onDeletPayment(PaymentDto payment);

  void onDiscount(double value);

  void onServiceTax(double value);

  void onChangeTo(double value);

  void setPaymentType(PaymentType paymentType);
}
