import 'package:paipfood_package/paipfood_package.dart';

class RebaseMenuLocalStorageUsecase {
  final ILocalStorage localStorage;
  RebaseMenuLocalStorageUsecase({
    required this.localStorage,
  });
  Future<void> call(Map<String, dynamic> menuMap) async {
    await localStorage.clearBox(CategoryModel.box);
    await localStorage.clearBox(ProductModel.box);
    await localStorage.clearBox(ComplementModel.box);
    await localStorage.clearBox(SizeModel.box);
    await localStorage.clearBox(ItemModel.box);

    final List<CategoryModel> categories = List.from(menuMap[CategoryModel.box].values);
    final List<ProductModel> products = List.from(menuMap[ProductModel.box].values);
    final List<ComplementModel> complements = List.from(menuMap[ComplementModel.box].values);
    final List<SizeModel> sizes = List.from(menuMap[SizeModel.box].values);
    final List<ItemModel> items = List.from(menuMap[ItemModel.box].values);
    await Future.wait([
      localStorage.putTransaction(CategoryModel.box, values: categories.map((e) => e.toMap()).toList()),
      localStorage.putTransaction(ProductModel.box, values: products.map((e) => e.toMap()).toList()),
      localStorage.putTransaction(ComplementModel.box, values: complements.map((e) => e.toMap()).toList()),
      localStorage.putTransaction(SizeModel.box, values: sizes.map((e) => e.toMap()).toList()),
      localStorage.putTransaction(ItemModel.box, values: items.map((e) => e.toMap()).toList()),
    ]);
  }
}
