import 'package:flutter/widgets.dart';
import 'package:core/core.dart';
import 'package:manager/l10n/l10n_provider.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/stores/bills_store.dart';
import 'package:manager/src/core/stores/delivery_areas_per_mile_store.dart';
import 'package:manager/src/modules/config/presenters/viewmodels/printer_viewmodel.dart';
import 'package:manager/src/modules/order/aplication/stores/order_store.dart';
import 'package:manager/src/modules/order/aplication/usecases/save_order_pdv_usecase.dart';
import 'package:manager/src/modules/pdv/aplication/stores/customer_store.dart';
import 'package:manager/src/modules/pdv/aplication/usecases/get_bill_by_id_usecase.dart';
import 'package:manager/src/modules/pdv/domain/payment_pdv_dto.dart';
import 'package:manager/src/modules/table/aplication/stores/table_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class OrderPdvStore extends ChangeNotifier {
  final IAddressApi addressApi;
  final CustomerStore customerStore;
  final DataSource dataSource;

  final PrinterViewmodel printerViewmodel;
  final OrderStore orderStore;
  final TableStore tableStore;
  final SaveOrderPdvUsecase saveOrderPdvUsecase;
  final GetBillByIdUsecase getBillByIdUsecase;
  final ILocalStorage localStorage;

  OrderPdvStore({
    required this.addressApi,
    required this.customerStore,
    required this.dataSource,
    required this.printerViewmodel,
    required this.orderStore,
    required this.tableStore,
    required this.saveOrderPdvUsecase,
    required this.getBillByIdUsecase,
    required this.localStorage,
  });

  final customerFormKey = GlobalKey<FormState>();
  final customerFinishOrderFormKey = GlobalKey<FormState>();

  DeliveryAreaPerMileEntity? get deliveryAreaPerMile => DeliveryAreasPerMileStore.instance.deliveryAreaPerMile;

  bool get billAvaliable => table != null;

  void rebuild() {
    notifyListeners();
  }

  Future<PaymentPdvDto> buildDto() async {
    if (billAvaliable) {
      final bill = await _getBillById();
      return PaymentPdvDto(bill: bill);
    }
    return PaymentPdvDto(order: order);
  }

  Future<BillModel> _getBillById() async {
    BillModel? bill = BillsStore.instance.getBillById(table!.billId!);
    bill ??= await getBillByIdUsecase.call(table!.billId!);
    return bill;
  }

  TableModel? get table => tableStore.selectedTable;
  EstablishmentModel get establishment => establishmentProvider.value;

  CustomerModel get customer => order.customer;
  CustomerModel get customerSingle => CustomerModel(name: l10nProiver.clienteAvulso, isSingleCustomer: true, phoneCountryCode: '+${establishmentProvider.value.phoneCountryCode}', addresses: []);

  OrderModel _generateDefaultOrder({int? number}) {
    return OrderModel(id: uuid, establishmentId: establishment.id, customer: customerSingle, orderNumber: number ?? establishmentProvider.value.currentOrderNumber + 1, status: OrderStatusEnum.accepted, orderType: OrderTypeEnum.consume, cartProducts: [], isLocal: true);
  }

  late OrderModel order = _generateDefaultOrder().copyWith(id: uuid);

  void setOrder(OrderModel order) {
    this.order = order;
    notifyListeners();
  }

  void onEdit(OrderModel order) {
    this.order = order;
  }

  Future<bool> init() async {
    try {
      await _resetPdv();

      return true;
    } catch (e) {
      toast.showError(e.toString());
      rethrow;
    }
  }

  Future<void> _resetPdv() async {
    await Future.delayed(50.milliseconds);
    order = _generateDefaultOrder();
    setSingleCustomer();
    notifyListeners();
  }

  void addProduct(CartProductDto cartProduct) {
    order.cartProducts.add(cartProduct);
    notifyListeners();
  }

  void removePorduct(CartProductDto cartProduct) {
    order.cartProducts.remove(cartProduct);
    notifyListeners();
  }

  void setSingleCustomer() {
    order = order.copyWith(customer: customerSingle, orderType: OrderTypeEnum.consume);
    notifyListeners();
  }

  Future<void> addAddressCustomer(AddressEntity address) async {
    order = order.copyWith(customer: order.customer.copyWith(address: address), orderType: OrderTypeEnum.delivery);
    await setDeliveryArea(address);
    notifyListeners();
  }

  void switchOrderType(OrderTypeEnum orderType) {
    order = order.copyWith(orderType: orderType);
    notifyListeners();
  }

  Future<void> setCustomer({required CustomerModel customer, AddressEntity? address}) async {
    order = order.copyWith(customer: customer.copyWith(address: address), orderType: OrderTypeEnum.consume);
    notifyListeners();
  }

  Future<void> setDeliveryArea(AddressEntity address) async {
    final tax = await addressApi.deliveryTax(
        request: DeliveryTaxRequest(
            lat: address.lat!,
            long: address.long!,
            establishmentLat: establishment.address!.lat!,
            establishmentLong: establishment.address!.long!,
            establishmentAddressId: establishment.address!.id,
            deliveryMethod: establishmentProvider.value.deliveryMethod,
            establishmentId: establishment.id,
            locale: LocaleNotifier.instance.locale));

    order = order.copyWith(deliveryTax: tax.price);

    notifyListeners();
  }

  Future<void> saveOrder() async {
    try {
      order = order.copyWith(orderNumber: -1);
      await saveOrderPdvUsecase.call(order: order, table: table);
      order = _generateDefaultOrder(number: establishmentProvider.value.currentOrderNumber + 2);
      await _resetPdv();
    } catch (_) {
      order = order.copyWith(orderNumber: establishmentProvider.value.currentOrderNumber + 1);
      await orderStore.addOrderToList(order);
      await printerViewmodel.printOrder(order: order);
    }
  }
}
