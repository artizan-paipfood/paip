import 'package:manager/src/core/stores/bills_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AddBillRealtimeUsecase {
  AddBillRealtimeUsecase();
  void call(Map map) {
    final bill = BillModel.fromMap(map);
    BillsStore.instance.setBill(bill);
  }
}
