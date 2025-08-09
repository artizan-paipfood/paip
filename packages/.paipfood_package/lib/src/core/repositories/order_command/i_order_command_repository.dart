import 'package:paipfood_package/paipfood_package.dart';

abstract interface class IOrderCommandRepository {
  Future<List<OrderCommandModel>> getByEstablishmentId(String id);
  Future<List<OrderCommandModel>> upsert({required List<OrderCommandModel> orderCommands, required AuthModel auth});
  Future<void> delete({required String id, required AuthModel auth, bool isDeleted});
}
