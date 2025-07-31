import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/menu/aplication/usecases/get_menu_local_usecase.dart';
import 'package:manager/src/modules/menu/aplication/usecases/rebase_menu_local_storage_usecase.dart';
import 'package:manager/src/modules/menu/domain/models/image_menu_model.dart';
import 'package:paipfood_package/paipfood_package.dart';

class GetMenuVmUsecase {
  final DataSource dataSource;
  final GetMenuLocalUsecase getMenuLocalUsecase;
  final GetMenuHttpUsecase getMenuHttpUsecase;
  final ILocalStorage localStorage;
  final IBucketRepository bucketRepo;
  final RebaseMenuLocalStorageUsecase rebaseMenuLocalStorageUsecase;

  const GetMenuVmUsecase({
    required this.dataSource,
    required this.getMenuLocalUsecase,
    required this.getMenuHttpUsecase,
    required this.localStorage,
    required this.bucketRepo,
    required this.rebaseMenuLocalStorageUsecase,
  });
  Future<MenuDto> call({bool isLocal = false}) async {
    Map<String, Map<dynamic, dynamic>?> req = {};
    if (isLocal) {
      req = await getMenuLocalUsecase.call();
    } else {
      req = await getMenuHttpUsecase.call(establishmentId: establishmentProvider.value.id);
      await rebaseMenuLocalStorageUsecase.call(req);
    }

    final Map<dynamic, CategoryModel> categories = req[CategoryModel.box]!.isNotEmpty ? req[CategoryModel.box] as Map<dynamic, CategoryModel> : {};

    final Map<dynamic, ProductModel> products = req[ProductModel.box]!.isNotEmpty ? req[ProductModel.box] as Map<dynamic, ProductModel> : {};

    final Map<dynamic, ComplementModel> complements = req[ComplementModel.box]!.isNotEmpty ? req[ComplementModel.box] as Map<dynamic, ComplementModel> : {};

    final Map<dynamic, ItemModel> items = req[ItemModel.box]!.isNotEmpty ? req[ItemModel.box] as Map<dynamic, ItemModel> : {};

    final Map<dynamic, SizeModel> sizes = req[SizeModel.box]!.isNotEmpty ? req[SizeModel.box] as Map<dynamic, SizeModel> : {};

    final mapProducts = products.values.groupListsBy((element) => element.categoryId);
    final itensMap = items.values.groupListsBy((element) => element.complementId);
    //Adiconando os produtos nas categorias
    if (mapProducts.isNotEmpty) {
      for (var category in categories.values) {
        if (mapProducts[category.id] != null) {
          category.products.addAll(mapProducts[category.id]!);
        }
      }
    }

    //-----------------------------------------------------------------------------
    //Adiconando itens nos complementos
    for (var complement in complements.values) {
      if (itensMap[complement.id] != null) {
        complement.items.addAll(itensMap[complement.id]!);
      }
    }
    //-------------------------------------------------------------------------------
    //Adiconando os complementos nos produtos
    products.values.map((product) {
      if (product.complementsIds.isNotEmpty) {
        for (var complementId in product.complementsIds) {
          if (complements[complementId] != null) product.complements.add(complements[complementId]!);
        }
      }
    }).toList();
    //-------------------------------------------------------------------------------
    //Adicionando os tamanhos nos produtos e itensPizza
    if (sizes.isNotEmpty) {
      if (sizes.isNotEmpty) {
        final sizesMap = sizes.values.groupListsBy((element) => element.sizeType);
        final sizesProduct = sizesMap[SizeType.product]?.groupListsBy((element) => element.productId);
        final sizesPizza = sizesMap[SizeType.pizza]?.groupListsBy((element) => element.itemId!);

        if (sizesProduct != null) {
          for (var key in sizesProduct.keys) {
            products[key]?.sizes.addAll(sizesProduct[key]!);
          }
        }

        if (sizesPizza != null) {
          for (var key in sizesPizza.keys) {
            items[key]?.sizes.addAll(sizesPizza[key]!);
          }
        }
      }
    }
    final menu = MenuDto.fromMap(req);

    await localStorage.put(MenuDto.box, key: MenuDto.box, value: menu.toMap());

    await localStorage.get(MenuDto.box, key: MenuDto.box);

    //- IMAGENS

    if (isLocal == false) {
      final imagesTempRequest = await localStorage.getAll(ImageMenuModel.box);
      final imagesTemp = imagesTempRequest?.values.map((e) => ImageMenuModel.fromMap(e)).toList() ?? [];

      final List<ImageMenuModel> imagesDelete = [];

      if (imagesTemp.isNotEmpty) {
        final groupImagesTemp = imagesTemp.groupListsBy((element) => element.imageMenuType);

        for (var image in groupImagesTemp[ImageMenuType.product]?.toList() ?? <ImageMenuModel>[]) {
          if (products[image.id] != null) {
            await localStorage.delete(ImageMenuModel.box, keys: [image.id]);
            continue;
          }
          imagesDelete.add(image);
        }
        for (var image in groupImagesTemp[ImageMenuType.item]?.toList() ?? <ImageMenuModel>[]) {
          if (items[image.id] != null) {
            await localStorage.delete(ImageMenuModel.box, keys: [image.id]);
            continue;
          }
          imagesDelete.add(image);
        }
      }

      if (imagesDelete.isNotEmpty) {
        await localStorage.delete(ImageMenuModel.box, keys: imagesDelete.map((e) => e.id).toList());
        await Future.wait(imagesDelete.map((e) => bucketRepo.deletefile(e.path)).toList());
      }
    }
    dataSource.menuVm = menu;
    return menu;
  }
}
