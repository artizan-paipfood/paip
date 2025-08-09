import 'package:core/core.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/pdv/aplication/stores/order_pdv_store.dart';
import 'package:manager/src/modules/pdv/aplication/stores/payment/i_payment_controller.dart';
import 'package:manager/src/modules/pdv/domain/payment_pdv_dto.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PaymentOrderController extends IPaymentController {
  final DataSource dataSource;
  final UpdateQueusRepository updateQueusRepo;
  final OrderPdvStore orderPdvStore;
  PaymentOrderController({
    required this.dataSource,
    required this.updateQueusRepo,
    required this.orderPdvStore,
  });

  double _changeTo = 0;

  PaymentType _paymentType = PaymentType.cash;

  OrderModel? _order;

  @override
  PaymentType get paymentType => _paymentType;

  @override
  List<PaymentType> get paymentMethodsAvaliable => dataSource.establishments.first.paymentMethod?.getAllPaymentTypes() ?? [];

  @override
  double get discount => _order?.discount ?? 0;

  @override
  double get serviceTax => _order?.tax ?? 0;

  @override
  double get changeTo => _changeTo;

  @override
  List<OrderModel> get orders => _order != null ? [_order!] : [];

  @override
  double get total => _order?.getAmount ?? 0;

  @override
  double get subTotal => _order?.getSubTotal ?? 0;

  @override
  double get totalPayments => _order?.getAmount ?? 0;

  @override
  double get remainingTotal => _order?.getAmount ?? 0;

  @override
  double get deliveryTax => _order?.deliveryTax ?? 0;

  @override
  List<PaymentDto> get payments => [];

  @override
  Future<void> initialize(PaymentPdvDto dto) async {
    reset();
    _order = dto.order;

    notifyListeners();
  }

  @override
  void reset() {
    _order = null;
    _changeTo = 0;
    _paymentType = PaymentType.cash;
  }

  @override
  Future<bool> onPay({required double value, required PaymentType paymentType, required String observation}) async {
    await finish();
    return true;
  }

  @override
  Future<void> finish() async {
    orderPdvStore.order = _order!.copyWith(paymentType: _paymentType, changeTo: _changeTo, acceptedDate: DateTime.now());
    await orderPdvStore.saveOrder();
  }

  @override
  Future<void> onDeletPayment(PaymentDto payment) async {}

  @override
  void onDiscount(double value) {
    _order = _order?.copyWith(discount: value);
    notifyListeners();
  }

  @override
  void onServiceTax(double value) {
    _order = _order?.copyWith(tax: value);

    notifyListeners();
  }

  @override
  void onChangeTo(double value) {
    _changeTo = value;
    _order = _order?.copyWith(changeTo: value);

    notifyListeners();
  }

  @override
  void setPaymentType(PaymentType paymentType) {
    _paymentType = paymentType;
    _order = _order?.copyWith(paymentType: paymentType);
    notifyListeners();
  }

  @override
  void notify() {
    notifyListeners();
  }
}
