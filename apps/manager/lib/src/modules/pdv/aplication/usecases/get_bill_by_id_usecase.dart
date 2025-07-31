import 'package:manager/src/core/stores/bills_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class GetBillByIdUsecase {
  final IBillRepository billRepo;
  GetBillByIdUsecase({
    required this.billRepo,
  });
  Future<BillModel> call(String id) async {
    final bill = await billRepo.getById(id);
    BillsStore.instance.setBill(bill);
    return bill;
  }
}
