import 'package:flutter/widgets.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/menu/aplication/usecases/get_menu_vm_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class MenuPdvStore extends ChangeNotifier {
  final GetMenuVmUsecase getMenuVmUsecase;
  final DataSource dataSource;

  MenuPdvStore({required this.getMenuVmUsecase, required this.dataSource});

  bool loaded = false;
  CategoryModel? categorySelected;
  List<ProductModel> _productsGrid = [];

  MenuDto get menuVm => dataSource.menuVm;

  List<ProductModel> get productsGrid => _productsGrid;

  EstablishmentModel get establishment => establishmentProvider.value;

  List<CategoryModel> get categories => menuVm.categories.values.toList()..sort((a, b) => a.index.compareTo(b.index));

  List<ComplementModel> get complements => menuVm.complements.values.toList();

  Future<bool> initialize() async {
    try {
      if (loaded) return true;
      await getMenuVmUsecase.call(isLocal: true);

      if (menuVm.categories.isNotEmpty) categorySelected = categories.first;
      _productsGrid = categorySelected?.productsSortAZ ?? [];
      loaded = true;
      return true;
    } catch (e) {
      toast.showError(e.toString());
      rethrow;
    }
  }

  void selectCategory(CategoryModel category) {
    categorySelected = category;
    _productsGrid = category.productsSortAZ;
    notifyListeners();
  }

  void searchProducts(String value) {
    if (value.isEmpty) {
      _productsGrid = categorySelected?.productsSortAZ ?? [];
    } else {
      final products = menuVm.categories.values.expand((category) => category.products).toList();
      _productsGrid = products.where((p) => p.name.toLowerCase().contains(value.toLowerCase())).toList();
    }
    notifyListeners();
  }
}
