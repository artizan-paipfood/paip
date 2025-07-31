import 'package:paipfood_package/paipfood_package.dart';

class GetMenuLocalUsecase {
  ILocalStorage localStorage;
  GetMenuLocalUsecase({
    required this.localStorage,
  });
  Future<Map<String, Map<dynamic, dynamic>?>> call() async {
    final categories = MapEntry(
        CategoryModel.box, (await localStorage.getAll(CategoryModel.box))?.map((key, value) => MapEntry(key, CategoryModel.fromMap(value))) ?? {});

    final products = MapEntry(
        ProductModel.box, (await localStorage.getAll(ProductModel.box))?.map((key, value) => MapEntry(key, ProductModel.fromMap(value))) ?? {});

    final complements = MapEntry(ComplementModel.box,
        (await localStorage.getAll(ComplementModel.box))?.map((key, value) => MapEntry(key, ComplementModel.fromMap(value))) ?? {});

    final sizes =
        MapEntry(SizeModel.box, (await localStorage.getAll(SizeModel.box))?.map((key, value) => MapEntry(key, SizeModel.fromMap(value))) ?? {});

    final items =
        MapEntry(ItemModel.box, (await localStorage.getAll(ItemModel.box))?.map((key, value) => MapEntry(key, ItemModel.fromMap(value))) ?? {});

    final map = Map.fromEntries([categories, products, complements, sizes, items]);
    return map;
  }
}
