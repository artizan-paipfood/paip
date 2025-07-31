import 'dart:math';

import 'package:flutter/material.dart';
import 'package:core/core.dart';

import 'package:paipfood_package/paipfood_package.dart';

class CustomerStore {
  final ILocalStorage localStorage;

  CustomerStore({
    required this.localStorage,
  });

  List<CustomerModel> customers = [];

  CustomerModel? selectedCustomer;

  var rebuildListCustomers = ValueNotifier(0);
  var rebuildCustomer = ValueNotifier(0);

  int get customersTabPage => 0;
  int get selectAddressTabPage => 1;
  int get infoCustomerTabPage => 2;

  List<CustomerModel> _cashedCustomers = [];

  Future<bool> init() async {
    if (_cashedCustomers.isNotEmpty) {
      customers = _cashedCustomers;
      rebuildListCustomers.value++;
      return true;
    }
    final result = await localStorage.getAll(CustomerModel.box) as Map;
    final filter = result.values.toList();
    final range = filter.getRange(0, min(filter.length, 50)).toList();
    customers = range.map((e) => CustomerModel.fromMap(e)).toList();
    _cashedCustomers = customers;
    rebuildListCustomers.value++;
    return true;
  }

  Future<void> getCustomersByNameOrPhone({required String nameOrPhone}) async {
    final result = await localStorage.getAll(CustomerModel.box) as Map;
    final filter = result.values.toList().where((customer) {
      final i = customer as Map;
      return i.contains(key: 'name', value: nameOrPhone) || i.contains(key: 'phone', value: nameOrPhone);
    }).toList();
    customers = filter.map((e) => CustomerModel.fromMap(e)).toList();
    rebuildListCustomers.value++;
  }

  Future<void> getAllCustomers() async {
    final result = await localStorage.getAll(CustomerModel.box) as Map;
    final filter = result.values.toList();
    customers = filter.map((e) => CustomerModel.fromMap(e)).toList();
    customers.sort((a, b) => a.name.compareTo(b.name));
    rebuildListCustomers.value++;
  }

  Future<void> addCustomer(CustomerModel customer) async {
    await localStorage.put(CustomerModel.box, key: customer.phone, value: customer.toMap());
  }

  Future<void> deleteCustomer(CustomerModel customer) async {
    await localStorage.delete(CustomerModel.box, keys: [customer.phone]);
    await getAllCustomers();
  }

  Future<void> saveCustomer(CustomerModel customer) async {
    await localStorage.put(CustomerModel.box, key: customer.phone, value: customer.toMap());
    selectedCustomer = customer;
    customers.addToSet(customer);
    rebuildCustomer.value++;
  }

  Future<void> deleteAddress({required AddressEntity address, required CustomerModel customer}) async {
    if (customer.address?.id == address.id) {
      customer.address = customer.addresses.firstWhereOrNull((element) => element.id != address.id);
    }
    customer.addresses.remove(address);
    await saveCustomer(customer);
  }
}
