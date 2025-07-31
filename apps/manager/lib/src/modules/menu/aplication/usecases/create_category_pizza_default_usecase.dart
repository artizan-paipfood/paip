import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CreateCategoryPizzaDefaultUsecase {
  final DataSource dataSource;

  CreateCategoryPizzaDefaultUsecase({required this.dataSource});

  Future<void> call({required BuildContext context, required CategoryModel category}) async {
    final store = context.read<MenuStore>();
    final List<ProductModel> products = [];
    final List<ComplementModel> complements = [];
    final List<ItemModel> itens = [];
    //*Products
    final ProductModel bigPizzaProduct = ProductModel(
      id: uuid,
      categoryId: category.id,
      index: 0,
      isPizza: true,
      establishmentId: establishmentProvider.value.id,
      name: context.i18n.pizzaGrandeDefault,
      qtyFlavorsPizza: QtyFlavorsPizza.two,
      complements: complements,
      syncState: SyncState.upsert,
      complementsIds: [],
      sizes: [],
    );
    final ProductModel smallPizzaProduct = ProductModel(
      id: uuid,
      categoryId: category.id,
      establishmentId: establishmentProvider.value.id,
      index: 1,
      isPizza: true,
      name: context.i18n.pizzaPequenaDefault,
      qtyFlavorsPizza: QtyFlavorsPizza.one,
      complements: complements,
      syncState: SyncState.upsert,
      complementsIds: [],
      sizes: [],
    );
    products.addAll([bigPizzaProduct, smallPizzaProduct]);
    category.products.addAll([bigPizzaProduct, smallPizzaProduct]);
    //*Borders
    final borderComplement = ComplementModel(
      establishmentId: establishmentProvider.value.id,
      id: uuid,
      index: -2,
      qtyMax: 1,
      name: context.i18n.bordas,
      idCategoryPizza: category.id,
      identifier: context.i18n.bordas,
      syncState: SyncState.upsert,
      complementType: ComplementType.optionalPizza,
      items: [],
    );
    complements.add(borderComplement);
    final catupiryBorder = ItemModel(id: uuid, index: 0, name: context.i18n.bordaCatupiry, establishmentId: establishmentProvider.value.id, complementId: borderComplement.id, price: 8, sizes: []);
    final cheddarBorder = ItemModel(id: uuid, index: 0, name: context.i18n.bordaCheddar, establishmentId: establishmentProvider.value.id, complementId: borderComplement.id, price: 8, sizes: []);
    borderComplement.items.addAll([catupiryBorder, cheddarBorder]);
    itens.addAll([catupiryBorder, cheddarBorder]);

    //*Pastas
    final pastaComplement = ComplementModel(
      establishmentId: establishmentProvider.value.id,
      id: uuid,
      index: -3,
      qtyMax: 1,
      idCategoryPizza: category.id,
      name: context.i18n.massas,
      identifier: context.i18n.massas,
      syncState: SyncState.upsert,
      complementType: ComplementType.optionalPizza,
      items: [],
    );
    final pastaTraditional = ItemModel(id: uuid, index: 0, name: context.i18n.massaTradicional, establishmentId: establishmentProvider.value.id, complementId: pastaComplement.id, sizes: []);
    itens.add(pastaTraditional);
    pastaComplement.items.add(pastaTraditional);
    complements.add(pastaComplement);

    //*Pizzas
    final pizzaComplement = ComplementModel(
      establishmentId: establishmentProvider.value.id,
      id: uuid,
      index: -1,
      complementType: ComplementType.pizza,
      name: context.i18n.sabores,
      identifier: context.i18n.sabores,
      idCategoryPizza: category.id,
      syncState: SyncState.upsert,
      items: [],
    );

    final mussarelaItem = ItemModel(id: uuid, index: 0, name: context.i18n.saborMussarela, description: context.i18n.descMussarela, establishmentId: establishmentProvider.value.id, complementId: pizzaComplement.id, itemtype: Itemtype.pizza, price: 40, sizes: []);
    final calabresaItem = ItemModel(id: uuid, index: 1, name: context.i18n.saborCalabresa, description: context.i18n.descCalabresa, establishmentId: establishmentProvider.value.id, complementId: pizzaComplement.id, itemtype: Itemtype.pizza, price: 25, sizes: []);
    complements.add(pizzaComplement);

    await store.insertItemPizza(category: category, item: mussarelaItem);
    await store.insertItemPizza(category: category, item: calabresaItem);

    for (final product in products) {
      product.complementsIds = complements.map((complement) => complement.id).toList();
    }

    await Future.wait([
      ...products.map((product) => store.saveProduct(product: product, category: category)),
      ...complements.map((complement) => store.insertComplement(complement)),
      ...itens.map((item) => store.saveItem(item: item, complement: complements.firstWhere((element) => element.id == item.complementId))),
    ]);
  }
}
