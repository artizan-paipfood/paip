import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class BillsStore extends ChangeNotifier {
  static BillsStore? _instance;
  // Avoid self instance
  BillsStore._();
  static BillsStore get instance => _instance ??= BillsStore._();

  final Map<String, BillModel> _bills = {};

  void setBill(BillModel bill) {
    _bills[bill.id] = bill;
    notifyListeners();
  }

  void setBills(List<BillModel> bills) {
    for (var bill in bills) {
      _bills[bill.id] = bill;
    }
    notifyListeners();
  }

  BillModel? getBillById(String id) => _bills[id];
}
