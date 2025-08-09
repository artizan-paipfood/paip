import 'package:core/core.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/stores/bills_store.dart';
import 'package:manager/src/core/stores/orders_store.dart';
import 'package:manager/src/modules/order/aplication/usecases/upsert_bill_usecase.dart';
import 'package:manager/src/modules/pdv/aplication/stores/payment/i_payment_controller.dart';
import 'package:manager/src/modules/pdv/domain/payment_pdv_dto.dart';
import 'package:manager/src/modules/table/aplication/stores/table_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PaymentBillController extends IPaymentController {
  final DataSource dataSource;
  final TableStore tableStore;
  final UpsertBillUsecase upsertBillUsecase;
  final TableRepository tableRepo;
  final UpdateQueusRepository updateQueusRepo;

  PaymentBillController({
    required this.dataSource,
    required this.tableStore,
    required this.upsertBillUsecase,
    required this.tableRepo,
    required this.updateQueusRepo,
  });

  //VARIABLES
  String _billId = '';

  double _changeTo = 0;

  PaymentType _paymentType = PaymentType.cash;

  List<OrderModel> _orders = [];

  @override
  PaymentType get paymentType => _paymentType;

  @override
  List<PaymentType> get paymentMethodsAvaliable => dataSource.establishments.first.paymentMethod?.getAllPaymentTypes() ?? [];

  @override
  double get discount => _bill.discount ?? 0;

  @override
  double get serviceTax => _bill.serviceTax ?? 0;

  @override
  double get changeTo => _changeTo;

  @override
  List<OrderModel> get orders => _orders;

  BillModel get _bill => BillsStore.instance.getBillById(_billId)!;

  @override
  double get total => _orders.fold(0, (previousValue, element) => previousValue + element.getAmount);

  @override
  double get subTotal => _orders.fold(0, (previousValue, element) => previousValue + element.subTotal);

  @override
  double get totalPayments => _bill.payments.fold(0, (previousValue, element) => previousValue + element.value);

  @override
  double get remainingTotal => ((total - totalPayments) + serviceTax) - discount;

  @override
  double get deliveryTax => throw UnimplementedError();

  @override
  List<PaymentDto> get payments => _bill.payments;

  @override
  Future<void> initialize(PaymentPdvDto dto) async {
    reset();
    if (dto.bill != null) {
      _billId = dto.bill!.id;
      _orders = OrdersStore.instance.getOrdersByBillId(_billId);
    }

    notifyListeners();
  }

  @override
  void reset() {
    _billId = '';
    _changeTo = 0;
    _paymentType = PaymentType.cash;
  }

  @override
  Future<bool> onPay({required double value, required PaymentType paymentType, required String observation}) async {
    final dto = PaymentDto(id: uuid, establishmentId: establishmentProvider.value.id, value: value, paymentType: paymentType, observation: observation, billId: _bill.id, createdAt: DateTime.now(), updatedAt: DateTime.now());
    await upsertBillUsecase.call(_bill.copyWith(payments: [..._bill.payments, dto]));

    if ((remainingTotal - value) <= 0) {
      await finish();
      return true;
    }
    return false;
  }

  @override
  Future<void> finish() async {
    final TableModel table = tableStore.selectedTable!;
    await tableStore.turnTableToAvaliable(table);

    Future.delayed(1.seconds, () {
      tableStore.setSelectedTable(table);
    });
  }

  @override
  Future<void> onDeletPayment(PaymentDto payment) async {
    BillsStore.instance.setBill(_bill.copyWith(payments: _bill.payments.where((e) => e.id != payment.id).toList()));
    await upsertBillUsecase.call(_bill);
  }

  @override
  void onDiscount(double value) {
    BillsStore.instance.setBill(_bill.copyWith(discount: value));
    notifyListeners();
  }

  @override
  void onServiceTax(double value) {
    BillsStore.instance.setBill(_bill.copyWith(serviceTax: value));

    notifyListeners();
  }

  @override
  void onChangeTo(double value) {
    _changeTo = value;

    notifyListeners();
  }

  @override
  void setPaymentType(PaymentType paymentType) {
    _paymentType = paymentType;
    notifyListeners();
  }

  @override
  void notify() {
    notifyListeners();
  }
}
