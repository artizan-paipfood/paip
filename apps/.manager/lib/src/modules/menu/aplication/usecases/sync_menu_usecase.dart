import 'package:manager/src/modules/menu/aplication/usecases/get_menu_vm_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SyncMenuUsecase {
  final IProductsRepository productRepo;
  final ICategoriesRepository categoryRepo;
  final IComplementsRepository complementRepo;
  final ISizesRepository sizeRepo;
  final IItemsRepository itemRepo;
  final GetMenuVmUsecase getMenuDatasourceUsecase;
  final GetMenuHttpUsecase getRestMenuUsecase;
  final IBucketRepository bucketRepo;
  SyncMenuUsecase({
    required this.productRepo,
    required this.categoryRepo,
    required this.complementRepo,
    required this.sizeRepo,
    required this.itemRepo,
    required this.getMenuDatasourceUsecase,
    required this.getRestMenuUsecase,
    required this.bucketRepo,
  });

  Future<void> call({required String establishmentId}) async {
    final MenuDto menuVm = await getMenuDatasourceUsecase.call(isLocal: true);

    final categoriesMap = menuVm.categories.values.groupListsBy((element) => element.syncState);
    final productsMap = menuVm.products.values.groupListsBy((element) => element.syncState);
    final complementsMap = menuVm.complements.values.groupListsBy((element) => element.syncState);
    final itemsMap = menuVm.items.values.groupListsBy((element) => element.syncState);
    final sizesMap = menuVm.sizes.values.groupListsBy((element) => element.syncState);

    final bool deleteProducts = productsMap[SyncState.upsert]?.toList().firstWhereOrNull((element) => element.isDeleted) != null;
    final bool deleteCategories = categoriesMap[SyncState.upsert]?.toList().firstWhereOrNull((element) => element.isDeleted) != null;
    final bool deleteComplements = complementsMap[SyncState.upsert]?.toList().firstWhereOrNull((element) => element.isDeleted) != null;
    final bool deleteItems = itemsMap[SyncState.upsert]?.toList().firstWhereOrNull((element) => element.isDeleted) != null;
    final bool deleteSizes = sizesMap[SyncState.upsert]?.toList().firstWhereOrNull((element) => element.isDeleted) != null;

    //* CATEGORIES
    if (categoriesMap[SyncState.upsert] != null) {
      final List<CategoryModel> categories_ = categoriesMap[SyncState.upsert]?.toList() ?? [];
      await categoryRepo.upsert(categories: categories_, auth: AuthNotifier.instance.auth);
    }

    //* PRODUCTS
    if (productsMap[SyncState.upsert] != null) {
      final List<ProductModel> products = productsMap[SyncState.upsert]?.toList() ?? [];
      await productRepo.upsert(products: products, auth: AuthNotifier.instance.auth);
    }

    //* COMPLEMENTS
    if (complementsMap[SyncState.upsert] != null) {
      final List<ComplementModel> complements_ = complementsMap[SyncState.upsert]?.toList() ?? [];
      await complementRepo.upsert(complements: complements_, auth: AuthNotifier.instance.auth);
    }

    //* ITEMS
    if (itemsMap[SyncState.upsert] != null) {
      final List<ItemModel> items_ = itemsMap[SyncState.upsert]?.toList() ?? [];
      await itemRepo.upsert(items: items_, auth: AuthNotifier.instance.auth);
    }

    //* SIZES
    if (sizesMap[SyncState.upsert] != null) {
      final List<SizeModel> sizes_ = sizesMap[SyncState.upsert]?.toList() ?? [];
      await sizeRepo.upsert(sizes: sizes_, auth: AuthNotifier.instance.auth);
    }

    //* DELETES
    if (deleteCategories) await categoryRepo.delete(id: '', auth: AuthNotifier.instance.auth, isDeleted: true);
    if (deleteProducts) {
      await productRepo.delete(id: '', auth: AuthNotifier.instance.auth, isDeleted: true);
    }
    if (deleteComplements) await complementRepo.delete(id: '', auth: AuthNotifier.instance.auth, isDeleted: true);
    if (deleteItems) {
      await itemRepo.delete(id: '', auth: AuthNotifier.instance.auth, isDeleted: true);
    }
    if (deleteSizes) await sizeRepo.delete(id: '', auth: AuthNotifier.instance.auth, isDeleted: true);

    await getRestMenuUsecase.call(establishmentId: establishmentId);
  }
}
