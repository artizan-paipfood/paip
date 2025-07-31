import 'package:paipfood_package/paipfood_package.dart';

class BuildMenuFromMapUsecase {
  Future<MenuDto> call(Map<String, Map<dynamic, dynamic>?> mapMenu) async {
    final Map<dynamic, CategoryModel> categories =
        mapMenu[CategoryModel.box]!.isNotEmpty ? mapMenu[CategoryModel.box] as Map<dynamic, CategoryModel> : {};

    final Map<dynamic, ProductModel> products = mapMenu[ProductModel.box]!.isNotEmpty ? mapMenu[ProductModel.box] as Map<dynamic, ProductModel> : {};

    final Map<dynamic, ComplementModel> complements =
        mapMenu[ComplementModel.box]!.isNotEmpty ? mapMenu[ComplementModel.box] as Map<dynamic, ComplementModel> : {};

    final Map<dynamic, ItemModel> items = mapMenu[ItemModel.box]!.isNotEmpty ? mapMenu[ItemModel.box] as Map<dynamic, ItemModel> : {};

    final Map<dynamic, SizeModel> sizes = mapMenu[SizeModel.box]!.isNotEmpty ? mapMenu[SizeModel.box] as Map<dynamic, SizeModel> : {};

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
    final menu = MenuDto.fromMap(mapMenu);

    return menu;
  }
}
