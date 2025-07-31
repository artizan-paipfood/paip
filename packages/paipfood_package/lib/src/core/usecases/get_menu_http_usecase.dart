import 'package:paipfood_package/paipfood_package.dart';

class GetMenuHttpUsecase {
  final IEstablishmentRepository establishmentRepo;
  GetMenuHttpUsecase({
    required this.establishmentRepo,
  });
  Future<Map<String, Map<dynamic, dynamic>>> call({required String establishmentId, bool onlyVisible = false}) async {
    final req = await establishmentRepo.getMenuByEstablishmentId(establishmentId: establishmentId, onlyVidible: onlyVisible);

    final categories = MapEntry(
        CategoryModel.box,
        req[CategoryModel.box] != null
            ? Map.fromIterable(req[CategoryModel.box]).map((key, value) => MapEntry(key['id'], CategoryModel.fromMap(value)))
            : {});

    final products = MapEntry(
        ProductModel.box,
        req[ProductModel.box] != null
            ? Map.fromIterable(req[ProductModel.box]).map((key, value) => MapEntry(key['id'], ProductModel.fromMap(value)))
            : {});

    final complements = MapEntry(
        ComplementModel.box,
        req[ComplementModel.box] != null
            ? Map.fromIterable(req[ComplementModel.box]).map((key, value) => MapEntry(key['id'], ComplementModel.fromMap(value)))
            : {});

    final sizes = MapEntry(SizeModel.box,
        req[SizeModel.box] != null ? Map.fromIterable(req[SizeModel.box]).map((key, value) => MapEntry(key['id'], SizeModel.fromMap(value))) : {});

    final items = MapEntry(ItemModel.box,
        req[ItemModel.box] != null ? Map.fromIterable(req[ItemModel.box]).map((key, value) => MapEntry(key['id'], ItemModel.fromMap(value))) : {});

    final map = Map.fromEntries([categories, products, complements, sizes, items]);
    return map;
  }
}
