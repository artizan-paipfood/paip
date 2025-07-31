import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:manager/l10n/l10n_provider.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/models/sync_model.dart';
import 'package:manager/src/modules/menu/aplication/usecases/create_category_pizza_default_usecase.dart';
import 'package:manager/src/modules/menu/aplication/usecases/delete_images_item_usecase.dart';
import 'package:manager/src/modules/menu/aplication/usecases/get_menu_vm_usecase.dart';
import 'package:manager/src/modules/menu/aplication/usecases/sync_menu_usecase.dart';
import 'package:manager/src/modules/menu/domain/models/image_menu_model.dart';
import 'package:paipfood_package/paipfood_package.dart';

bool syncReq = false;

class MenuStore extends ChangeNotifier {
  final DataSource dataSource;
  final IBucketRepository bucketRepo;
  final SyncMenuUsecase syncMenuUsecase;
  final GetMenuVmUsecase getMenuDatasourceUsecase;
  final ILocalStorage localStorage;
  final DeleteImagesUsecase deleteImagesUsecase;
  final CreateCategoryPizzaDefaultUsecase createCategoryPizzaDefaultUsecase;
  MenuStore({
    required this.dataSource,
    required this.bucketRepo,
    required this.syncMenuUsecase,
    required this.getMenuDatasourceUsecase,
    required this.localStorage,
    required this.deleteImagesUsecase,
    required this.createCategoryPizzaDefaultUsecase,
  });

  MenuDto menuVm = MenuDto(
    categories: {},
    complements: {},
    items: {},
    products: {},
    sizes: {},
  );

  CategoryModel? categorySelected;
  ComplementModel? complementSelected;
  ProductModel? productSelected;
  ItemModel? itemSelected;
  ItemModel? itemPizzaSelected;
  final scrollControllerCategorias = ScrollController();
  final scrollControllerComplements = ScrollController();

  late List<CategoryModel> categories;
  List<CategoryModel> get _categories => menuVm.categories.values.toList().sorted((a, b) => a.index.compareTo(b.index));
  late List<ComplementModel> complements;
  List<ComplementModel> get _complements => menuVm.complements.values.toList().sorted((a, b) => a.index.compareTo(b.index));

  var rebuildCategories = ValueNotifier(0);
  var rebuildProdutcs = ValueNotifier(0);
  var rebuildComplements = ValueNotifier(0);
  var rebuildItems = ValueNotifier(0);

  void _sortCategoriesComplements() {
    categories = _categories;
    complements = _complements;
    for (final categorie in categories) {
      categorie.products = categorie.productsSortIndex;
    }
    for (final complement in complements) {
      complement.items = complement.itemsSortIndex;
    }
  }

//$-----------------------------------GENERICS-------------------------------------
  Future<String> init() async {
    final req = await localStorage.get(SyncRequestModel.box, key: SyncRequestModel.box);
    if (req != null) {
      syncRequest.value = SyncRequestModel.fromMap(req);
      // bool isLocal = syncRequest.value.menu;
    }
    // const bool isLocal = false;
    if (menuVm.categories.isEmpty) menuVm = await getMenuDatasourceUsecase.call();
    _sortCategoriesComplements();
    return "Sucess";
  }

  Future<void> syncMenu() async {
    try {
      await syncMenuUsecase.call(establishmentId: establishmentProvider.value.id);
      syncReq = false;
      syncRequest.value = syncRequest.value.copyWith(menu: false);
      await localStorage.put(SyncRequestModel.box, key: SyncRequestModel.box, value: syncRequest.value.toMap());
      toast.showSucess(l10nProiver.sincronizado);
      menuVm = await getMenuDatasourceUsecase.call();
      rebuildCategories.value++;
      rebuildComplements.value++;
    } catch (e) {
      toast.showError(e.toString());
      syncReq = false;
      syncRequest.value = syncRequest.value.copyWith(menu: false);
      menuVm = await getMenuDatasourceUsecase.call();
      rebuildCategories.value++;
      rebuildComplements.value++;
    }
  }

  void changeCategoryType({required CategoryModel category, required CategoryType type}) {
    category.categoryType = type;
    rebuildCategories.value++;
  }

  Future<void> addComplementToProduct({required ComplementModel complement, required ProductModel product}) async {
    if (product.complements.where((e) => e.id == complement.id).isNotEmpty) return;
    product
      ..complements.add(complement)
      ..complementsIds.add(complement.id)
      ..syncState = SyncState.upsert;
    await syncProduct(product);
  }

  Future<void> removeComplementToProduct({required ComplementModel complement, required ProductModel product}) async {
    product
      ..complements.remove(complement)
      ..complementsIds.remove(complement.id)
      ..syncState = SyncState.upsert;

    await syncProduct(product);
    rebuildProdutcs.value++;
  }

//$-----------------------------------INSERTS-----------------------------------
  Future<void> insertCategory(CategoryModel category) async {
    menuVm.categories.addEntries([MapEntry(category.id, category)]);
    await syncCategorie(category);
    _sortCategoriesComplements();
    rebuildCategories.value++;
    if (categories.where((element) => element.isDeleted == false).length > 1) {
      scrollControllerCategorias.jumpTo(scrollControllerCategorias.position.maxScrollExtent + 300);
    }
  }

  Future<void> insertCategoryPizza({required BuildContext context, required CategoryModel category}) async {
    menuVm.categories.addEntries([MapEntry(category.id, category)]);
    await createCategoryPizzaDefaultUsecase.call(context: context, category: category);
    category.syncState = SyncState.upsert;
    await syncCategorie(category);
    _sortCategoriesComplements();
    rebuildCategories.value++;
    if (categories.where((element) => element.isDeleted == false).length > 1) {
      scrollControllerCategorias.jumpTo(scrollControllerCategorias.position.maxScrollExtent + 300);
    }
  }

  void insertSize(ProductModel product) {
    product.price = 0;
    final SizeModel size = SizeModel(
      id: uuid,
      syncState: SyncState.upsert,
      establishmentId: establishmentProvider.value.id,
      productId: product.id,
      price: 0.0,
    );
    if (product.sizes.where((element) => element.isDeleted == false).isEmpty) size.isPreSelected = true;
    product.sizes.add(size);
  }

  void insertProduct(CategoryModel category_) {
    final ProductModel product = ProductModel(
      id: uuid,
      categoryId: category_.id,
      establishmentId: establishmentProvider.value.id,
      index: category_.products.length,
      complements: [],
      sizes: [],
      complementsIds: [],
    );
    menuVm.products.addEntries([MapEntry(product.id, product)]);
    category_.products.add(product);
    productSelected = product;
    rebuildProdutcs.value++;
  }

  void insertProductPizza({required CategoryModel category_}) {
    final complements = category_.products.first.complements;
    final complementPizza = complements.firstWhere((element) => element.complementType == ComplementType.pizza);

    final ProductModel product = ProductModel(
      id: uuid,
      categoryId: category_.id,
      establishmentId: establishmentProvider.value.id,
      index: category_.products.length,
      isPizza: true,
      complements: complements,
      qtyFlavorsPizza: QtyFlavorsPizza.two,
      sizes: [],
      complementsIds: complements.map((e) => e.id).toList(),
    );

    for (var item in complementPizza.items) {
      item.sizes.add(SizeModel(
        id: uuid,
        establishmentId: establishmentProvider.value.id,
        productId: product.id,
        itemId: item.id,
        price: 0,
        sizeType: SizeType.pizza,
      ));
    }

    category_.products.add(product);
    rebuildProdutcs.value++;
  }

  Future<void> insertComplement(ComplementModel complement) async {
    menuVm.complements.addEntries([MapEntry(complement.id, complement)]);
    complement.syncState = SyncState.upsert;
    _sortCategoriesComplements();
    complementSelected = complement;
    rebuildComplements.value++;
    if (complements.where((comp) => comp.complementType == ComplementType.item && comp.isDeleted == false).length > 1) {
      scrollControllerComplements.jumpTo(scrollControllerComplements.position.maxScrollExtent + 300);
    }
    await syncComplement(complement);
  }

  void insertItem(ComplementModel complement_) {
    final ItemModel item = ItemModel(id: uuid, complementId: complement_.id, establishmentId: establishmentProvider.value.id, index: complement_.items.length, sizes: []);
    complement_.items.add(item);
    itemSelected = item;
    rebuildItems.value++;
  }

  Future<void> insertItemPizza({required CategoryModel category, ItemModel? item}) async {
    final complement = category.products.first.complements.firstWhere((element) => element.complementType == ComplementType.pizza);
    final item_ = item ?? ItemModel(id: uuid, index: complement.items.length, establishmentId: establishmentProvider.value.id, complementId: complement.id, sizes: [], itemtype: Itemtype.pizza);
    final List<SizeModel> sizes = [];
    complement.items.add(item_);
    await Future.forEach(category.products, (element) {
      final size = SizeModel(
        id: uuid,
        establishmentId: establishmentProvider.value.id,
        productId: element.id,
        itemId: item_.id,
        price: 0,
        sizeType: SizeType.pizza,
      );
      sizes.add(size);
    });
    item_.sizes.addAll(sizes);
    rebuildProdutcs.value++;
  }

//$-----------------------------------SAVES-----------------------------------

  Future<void> saveProduct({required ProductModel product, required CategoryModel category}) async {
    productSelected = null;
    if (product.sizes.isEmpty) product.priceFrom = null;
    if (product.sizes.isNotEmpty) {
      product
        ..priceFrom = product.priceFromSizes
        ..price = 0;
    }
    final List<SizeModel> sizesToDelete = [];
    final List<String> idSizesToDelete = [];
    await Future.wait([
      ...product.sizes.map((size) async {
        size.syncState = SyncState.upsert;
        if (size.isDeleted) {
          sizesToDelete.add(size);
          return;
        }
        await localStorage.put(SizeModel.box, key: size.id, value: size.toMap());
      }),
    ]);
    await Future.forEach(sizesToDelete, (size) async {
      if (size.createdAt == null) {
        idSizesToDelete.add(size.id);
        return;
      }
      await localStorage.put(SizeModel.box, key: size.id, value: size.toMap());
    });
    product.syncState = SyncState.upsert;
    await syncProduct(product);
    await localStorage.delete(SizeModel.box, keys: idSizesToDelete);
    if (category.products.length <= 1) {
      category.syncState = SyncState.upsert;
      await syncCategorie(category);
    }
    rebuildProdutcs.value++;
  }

  Future<void> saveItem({required ItemModel item, required ComplementModel complement}) async {
    item.syncState = SyncState.upsert;
    itemSelected = null;
    await syncItem(item);
    if (complement.items.length <= 1) {
      complement.syncState = SyncState.upsert;
      await localStorage.put(ComplementModel.box, key: complement.id, value: complement.toMap());
    }
    rebuildItems.value++;
  }

  Future<void> saveItemPizza({required ItemModel item, required CategoryModel category}) async {
    item.syncState = SyncState.upsert;
    await Future.wait(item.sizes.map((e) async {
      e.syncState = SyncState.upsert;
      await localStorage.put(SizeModel.box, key: e.id, value: e.toMap());
    }));
    await Future.forEach(category.products, (product) async {
      final price = item.sizes.where((element) => element.productId == product.id && element.price > 0).sorted((a, b) => a.price.compareTo(b.price)).first.price;
      product.priceFrom = price;
      await syncProduct(product);
    });
    itemPizzaSelected = null;
    await syncItem(item);
    rebuildProdutcs.value++;
  }

  Future<void> saveCategoryPizza(CategoryModel newCategory) async {
    newCategory.syncState = SyncState.upsert;
    menuVm.categories.addEntries([MapEntry(newCategory.id, newCategory)]);
    await Future.wait(
      newCategory.products.where((element) => element.isDeleted).map((e) async {
        await _deleteSizesByProducPizza(e);
      }).toList(),
    );

    await Future.wait(newCategory.products.map((e) async => localStorage.put(ProductModel.box, key: e.id, value: e.toMap())).toList());

    final complements = newCategory.products.first.complements;
    for (var complement in complements.where((element) => element.complementType != ComplementType.item)) {
      complement.syncState = SyncState.upsert;
      await localStorage.put(ComplementModel.box, key: complement.id, value: complement.toMap());
      await Future.wait(complement.items.map((item) async {
        item.syncState = SyncState.upsert;
        await localStorage.put(ItemModel.box, key: item.id, value: item.toMap());
        await Future.wait(item.sizes.map((size) async {
          size.syncState = SyncState.upsert;
          await localStorage.put(SizeModel.box, key: size.id, value: size.toMap());
        }));
      }).toList());
    }
    await syncCategorie(newCategory);
    rebuildCategories.value++;
  }

  Future<void> saveImageProduct({required Uint8List bytes, required ProductModel product}) async {
    if (product.createdAt == null) {
      final imageMenu = ImageMenuModel(path: product.imagePath, id: product.id, imageMenuType: ImageMenuType.product);
      await localStorage.put(ImageMenuModel.box, key: product.id, value: imageMenu.toMap());
    }
    product
      ..imageCacheId = DateTime.now().toString()
      ..imageBytes = bytes
      ..image = product.imagePath
      ..syncState = SyncState.upsert;
    await syncProduct(product);
    await bucketRepo.upsertImage(fileName: product.imagePath, imageBytes: bytes);
    rebuildProdutcs.value++;
  }

  Future<void> saveImageItem({required Uint8List bytes, required ItemModel item}) async {
    if (item.createdAt == null) {
      final imageMenu = ImageMenuModel(path: item.imagePath, id: item.id, imageMenuType: ImageMenuType.item);
      await localStorage.put(ImageMenuModel.box, key: item.id, value: imageMenu.toMap());
    }
    item
      ..imageCacheId = DateTime.now().toString()
      ..imageBytes = bytes
      ..image = item.imagePath
      ..syncState = SyncState.upsert;
    await syncItem(item);
    await bucketRepo.upsertImage(fileName: item.imagePath, imageBytes: bytes);
    if (item.itemtype == Itemtype.pizza) {
      rebuildProdutcs.value++;
    }
    rebuildItems.value++;
  }

  //$----------------------------------DELETES-----------------------------------
  Future<void> deleteCategory({required CategoryModel category}) async {
    category
      ..isDeleted = true
      ..syncState = SyncState.upsert;
    await localStorage.delete(ProductModel.box, keys: category.products.map((e) => e.id).toList());
    if (category.imageProducts().isNotEmpty) {
      await deleteImagesUsecase.call(category.imageProducts());
    }
    if (category.createdAt == null) {
      await Future.wait([
        localStorage.delete(CategoryModel.box, keys: [category.id]),
        localStorage.delete(ProductModel.box, keys: category.idsProducts),
        localStorage.delete(SizeModel.box, keys: category.idsSizesFromPorducts()),
      ]);
      rebuildCategories.value++;
      return;
    }

    await syncCategorie(category);
    categorySelected = null;
    rebuildCategories.value++;
  }

  void deleteSize({required ProductModel product, required SizeModel size}) {
    final bool preselected = size.isPreSelected;
    size
      ..syncState = SyncState.upsert
      ..isDeleted = true
      ..isPreSelected = false;
    if (preselected && product.sizes.where((element) => element.isPreSelected == true).isEmpty) {
      final size_ = product.sizes.firstWhereOrNull((element) => element.isDeleted == false);
      size_?.isPreSelected = true;
    }
  }

  void deleteProduct({required ProductModel product, required CategoryModel category}) {
    category.products.remove(product);
    if (product.createdAt == null) {
      Future.wait([
        localStorage.delete(ProductModel.box, keys: [product.id]),
        localStorage.delete(SizeModel.box, keys: product.sizesIds),
      ]);
      rebuildProdutcs.value++;
      return;
    }
    product
      ..isDeleted = true
      ..syncState = SyncState.upsert;
    syncProduct(product);
    productSelected = null;
    rebuildProdutcs.value++;
  }

  Future<void> deleteImageProduct(ProductModel product) async {
    if (product.image == null) return;
    await bucketRepo.deletefile(product.imagePath);
    product
      ..image = null
      ..imageBytes = null
      ..syncState = SyncState.upsert;
    await syncProduct(product);
  }

  Future<void> deleteImageItem(ItemModel item) async {
    if (item.image == null) return;
    await bucketRepo.deletefile(item.imagePath);
    item
      ..image = null
      ..imageBytes = null
      ..syncState = SyncState.upsert;
    await syncItem(item);
  }

  void deleteItemOptionalPizza(ItemModel item) {
    item
      ..isDeleted = true
      ..syncState = SyncState.upsert;
    rebuildItems.value++;
  }

  Future<void> deleteComplement(ComplementModel complement) async {
    complement
      ..isDeleted = true
      ..syncState = SyncState.upsert;
    if (complement.imageItens().isNotEmpty) {
      await deleteImagesUsecase.call(complement.imageItens());
    }
    if (complement.createdAt == null) {
      await Future.wait([
        localStorage.delete(ComplementModel.box, keys: [complement.id]),
        localStorage.delete(ItemModel.box, keys: complement.itemIds),
      ]);
      rebuildComplements.value++;
      rebuildProdutcs.value++;
      return;
    }
    await syncComplement(complement);
    rebuildComplements.value++;
    rebuildProdutcs.value++;
  }

  Future<void> deleteItem(ItemModel item) async {
    final index = complementSelected?.items.indexOf(item);
    complementSelected?.items[index!] = item.copyWith(isDeleted: true, syncState: SyncState.upsert);
    if (item.image != null) {
      await deleteImagesUsecase.call([item.image!]);
    }
    if (item.createdAt == null) {
      await localStorage.delete(ItemModel.box, keys: [item.id]);
      rebuildItems.value++;
      return;
    }

    await syncItem(item);
    rebuildItems.value++;
  }

  Future<void> deleteItemPizza({required ItemModel item, required CategoryModel category, required ComplementModel complement}) async {
    complement.items.remove(item);
    item
      ..isDeleted = true
      ..syncState = SyncState.upsert;
    itemPizzaSelected = null;
    await Future.wait(item.sizes.map((size) async {
      size
        ..syncState = SyncState.upsert
        ..isDeleted = true;
      await localStorage.put(SizeModel.box, key: size.id, value: size.toMap());
    }));
    await Future.forEach(category.products, (product) async {
      final price = item.sizes.firstWhere((element) => element.productId == product.id).price;
      if ((product.priceFrom ?? 0) == price) {
        const double priceFrom = 1857585585658585857.0;
        complement.items.map((e) {
          if ((e.priceFrom ?? 0) < priceFrom) {
            e.priceFrom = price;
          }
        });
        product.priceFrom = priceFrom;
        await syncProduct(product);
      }
    });

    await syncItem(item);
    rebuildProdutcs.value++;
  }

  Future<void> deleteProductPizza(ProductModel product) async {
    product
      ..isDeleted = true
      ..syncState = SyncState.upsert;
    rebuildProdutcs.value++;
  }

  Future<void> _deleteSizesByProducPizza(ProductModel product) async {
    final complement = product.complements.firstWhere((element) => element.complementType == ComplementType.pizza);

    final List<String> sizes = [];

    await Future.forEach(complement.items, (item) {
      for (var size in item.sizes) {
        if (size.productId == product.id) {
          sizes.add(size.id);
        }
      }
    });
    await localStorage.delete(SizeModel.box, keys: sizes);

    rebuildProdutcs.value++;
  }

  Future<void> deleteCategoryPizza(CategoryModel category) async {
    category
      ..isDeleted = true
      ..syncState = SyncState.upsert;
    final List<String> products = [];
    final List<String> complements = [];
    final List<String> items = [];
    final List<String> sizes = [];

    category.products.map((product) {
      products.add(product.id);
    }).toList();
    await Future.forEach(category.products.first.complements, (complement) {
      complements.add(complement.id);
      for (var item in complement.items) {
        items.add(item.id);
        for (var size in item.sizes) {
          sizes.add(size.id);
        }
      }
    });

    await Future.wait([
      localStorage.delete(ProductModel.box, keys: products),
      localStorage.delete(ComplementModel.box, keys: complements),
      localStorage.delete(ItemModel.box, keys: items),
      localStorage.delete(SizeModel.box, keys: sizes),
    ]);
    await syncCategorie(category);
    rebuildCategories.value++;
  }

  //$-----------------------------------CANCELSAVES-----------------------------------

  void cancelSaveProduct({required ProductModel product, required CategoryModel category}) {
    productSelected = null;
    if (product.createdAt == null && product.syncState == SyncState.none) {
      category.products.remove(product);
      rebuildProdutcs.value++;
      return;
    }
    rebuildProdutcs.value++;
  }

  void cancelSaveItem({required ItemModel item, required ComplementModel complement}) {
    itemSelected = null;
    if (item.createdAt == null && item.syncState == SyncState.none) {
      complement.items.remove(item);
      rebuildItems.value++;
      return;
    }
    rebuildItems.value++;
  }

  void cancelSaveItemPizza({required ItemModel item, required ComplementModel complement}) {
    if (item.createdAt == null && item.syncState == SyncState.none) {
      complement.items.remove(item);
      item.sizes.clear();
      rebuildProdutcs.value++;
      return;
    }
    itemPizzaSelected = null;
    rebuildProdutcs.value++;
  }

  //$-----------------------------------ORDENABLES------------------------------------

  void ordeningCategories({required int oldIndex, required int newIndex}) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final category = categories[oldIndex];
    categories
      ..removeAt(oldIndex)
      ..insert(newIndex, category);

    for (final category in categories) {
      category.index = categories.indexOf(category);
      syncCategorie(category);
    }
  }

  void ordeningProducts({required int oldIndex, required int newIndex, required CategoryModel category}) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final product = category.products[oldIndex];
    category.products.removeAt(oldIndex);
    category.products.insert(newIndex, product);

    for (final product in category.products) {
      product.index = category.products.indexOf(product);
      syncProduct(product);
    }
  }

  void ordeningComplements({required int oldIndex, required int newIndex}) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final complement = complements[oldIndex];
    complements
      ..removeAt(oldIndex)
      ..insert(newIndex, complement);

    for (final complement in complements) {
      complement.index = complements.indexOf(complement);
      syncComplement(complement);
    }
  }

  void ordeningItens({required int oldIndex, required int newIndex, required ComplementModel complement}) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final item = complement.items[oldIndex];
    complement.items.removeAt(oldIndex);
    complement.items.insert(newIndex, item);

    for (final item in complement.items) {
      item.index = complement.items.indexOf(item);
      syncItem(item);
    }
  }

  //$-----------------------------------DUPLICATES------------------------------------
  Future<void> duplicateComplement(ComplementModel complement) async {
    ComplementModel newComplement = complement.clone().copyWith(id: uuid, identifier: '${complement.identifier}-copy');
    final List<ItemModel> itens = [];
    for (final item in newComplement.items) {
      itens.add(item.clone().copyWith(id: uuid, complementId: newComplement.id));
    }
    newComplement = newComplement.copyWith(items: itens);
    complements.add(newComplement);

    await syncComplement(newComplement);
    await Future.forEach(itens, (i) => syncItem(i));
  }

  //$-----------------------------------SET------------------------------------
  void setItem(ItemModel value) {
    if (itemSelected != value) {
      itemSelected = value;
      rebuildItems.value++;
      return;
    }
    itemSelected = null;
    rebuildItems.value++;
  }

  void setItemPizza(ItemModel value) {
    if (itemPizzaSelected != value) {
      itemPizzaSelected = value;
      rebuildProdutcs.value++;
      return;
    }
    itemPizzaSelected = null;
    rebuildProdutcs.value++;
  }

  void setComplement(ComplementModel value) {
    if (complementSelected != value) {
      complementSelected = value;
      rebuildComplements.value++;
      return;
    }
    complementSelected = null;
    rebuildComplements.value++;
  }

  void setProduct(ProductModel product) {
    if (productSelected != product) {
      productSelected = product;
      rebuildProdutcs.value++;
      return;
    }
    productSelected = null;
    rebuildProdutcs.value++;
  }

  void setPreselectedSize({required ProductModel product, required SizeModel size}) {
    for (var element in product.sizes) {
      element.isPreSelected = false;
    }
    size.isPreSelected = true;
  }

  void setCategory(CategoryModel value) {
    productSelected = null;
    itemSelected = null;
    if (categorySelected != value) {
      categorySelected = value;
      rebuildCategories.value++;
      return;
    }
    categorySelected = null;
    rebuildCategories.value++;
  }
  //$-----------------------------------SYNC-----------------------------------

  Future<void> syncItem(
    ItemModel value,
  ) async {
    syncReq = true;
    syncRequest.value = syncRequest.value.copyWith(menu: true);
    value.syncState = SyncState.upsert;
    await Future.wait([
      localStorage.put(ItemModel.box, key: value.id, value: value.toMap()),
      localStorage.put(SyncRequestModel.box, key: SyncRequestModel.box, value: syncRequest.value.toMap()),
    ]);
  }

  Future<void> syncSize(
    SizeModel value,
  ) async {
    syncReq = true;
    syncRequest.value = syncRequest.value.copyWith(menu: true);
    value.syncState = SyncState.upsert;
    await Future.wait([
      localStorage.put(SizeModel.box, key: value.id, value: value.toMap()),
      localStorage.put(SyncRequestModel.box, key: SyncRequestModel.box, value: syncRequest.value.toMap()),
    ]);
  }

  Future<void> syncProduct(ProductModel value) async {
    syncReq = true;
    syncRequest.value = syncRequest.value.copyWith(menu: true);
    value.syncState = SyncState.upsert;
    await Future.wait([
      localStorage.put(ProductModel.box, key: value.id, value: value.toMap()),
      localStorage.put(SyncRequestModel.box, key: SyncRequestModel.box, value: syncRequest.value.toMap()),
    ]);
  }

  Future<void> syncComplement(
    ComplementModel value,
  ) async {
    syncReq = true;
    syncRequest.value = syncRequest.value.copyWith(menu: true);
    value.syncState = SyncState.upsert;
    await Future.wait([
      localStorage.put(ComplementModel.box, key: value.id, value: value.toMap()),
      localStorage.put(SyncRequestModel.box, key: SyncRequestModel.box, value: syncRequest.value.toMap()),
    ]);
  }

  Future<void> syncCategorie(CategoryModel value) async {
    syncReq = true;
    syncRequest.value = syncRequest.value.copyWith(menu: true);
    value.syncState = SyncState.upsert;
    await Future.wait([
      localStorage.put(CategoryModel.box, key: value.id, value: value.toMap()),
      localStorage.put(SyncRequestModel.box, key: SyncRequestModel.box, value: syncRequest.value.toMap()),
    ]);
  }
}
