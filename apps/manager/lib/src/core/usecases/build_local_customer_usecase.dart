import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class BuildLocalCustomerUsecase {
  final ILocalStorage localStorage;

  BuildLocalCustomerUsecase({required this.localStorage});

  Future<CustomerModel> call(CustomerModel customer) async {
    final local = await localStorage.get(CustomerModel.box, key: customer.phone);
    final qtyOrders = local != null ? CustomerModel.fromMap(local).qtyOrders : 0;
    if (local == null) {
      if (customer.address != null) return customer.copyWith(addresses: [customer.address!]);
    }
    final List<AddressEntity> addressesResult = [];
    String name = customer.name;
    if (customer.address != null) {
      addressesResult.add(customer.address!);
    }

    final customerLocal = CustomerModel.fromMap(local!);
    name = customerLocal.name;
    final addressesLocal = customerLocal.addresses;

    for (final address in addressesLocal) {
      if (address.lat != (customer.address?.lat ?? 0.0) && address.long != (customer.address?.long ?? 0.0)) {
        addressesResult.add(address);
      }
    }
    return customer.copyWith(addresses: addressesResult, name: name, qtyOrders: qtyOrders);
  }
}
