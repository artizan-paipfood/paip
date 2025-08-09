import 'package:paipfood_package/paipfood_package.dart';

class UpsertBillUsecase {
  final BillRepository billRepo;
  final UpdateQueusRepository updateQueusRepo;

  UpsertBillUsecase({
    required this.billRepo,
    required this.updateQueusRepo,
  });

  Future<BillModel> call(BillModel bill) async {
    final result = await billRepo.upsert(bills: [bill], auth: AuthNotifier.instance.auth);
    await updateQueusRepo.upsert(UpdateQueusModel.fromBill(bill));
    return result.first;
  }
}
