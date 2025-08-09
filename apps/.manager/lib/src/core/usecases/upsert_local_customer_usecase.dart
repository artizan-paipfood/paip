import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/usecases/build_local_customer_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class UpsertLocalCustomerUsecase {
  final ILocalStorage localStorage;
  final DataSource dataSource;
  final BuildLocalCustomerUsecase buildCustomerUseCase;

  UpsertLocalCustomerUsecase({
    required this.localStorage,
    required this.dataSource,
    required this.buildCustomerUseCase,
  });

  Future<void> call({required CustomerModel customer, required bool increment}) async {
    if (customer.isSingleCustomer) return;

    CustomerModel customerResult = await buildCustomerUseCase.call(customer);
    if (increment) {
      customerResult = customerResult.copyWith(qtyOrders: customerResult.qtyOrders + 1);
    }
    if (increment == false) {
      final qty = customerResult.qtyOrders - 1;
      customerResult = customerResult.copyWith(qtyOrders: qty <= 0 ? 0 : qty);
    }
    await localStorage.put(CustomerModel.box, key: customer.phone, value: customerResult.toMap());
  }
}
