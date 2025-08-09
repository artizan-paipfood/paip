import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CartProductStore extends ChangeNotifier {
  CartProductDto? cartProdutVm;
  var rebuildTotal = ValueNotifier(0);

  void init({required ProductModel product, CartProductDto? cartProduct}) {
    if (cartProduct != null) {
      cartProdutVm = cartProduct.clone();
      cartProdutVm!.price = cartProduct.price / cartProdutVm!.qty;
      return;
    }
    final SizeModel? size = product.sizes.firstWhereOrNull((element) => element.isPreSelected);
    cartProdutVm = CartProductDto(
        id: uuid,
        product: product,
        itemsCartMap: {},
        qtyFlavorsPizza: product.qtyFlavorsPizza,
        price: product.price + (size?.price ?? 0),
        size: size);
  }

  void switchQtyFlavorPizza(QtyFlavorsPizza qtyFlavorsPizza) {
    if (cartProdutVm?.qtyFlavorsPizza == qtyFlavorsPizza) return;
    cartProdutVm!.switchQtyFlavorPizza(qtyFlavorsPizza);
    notifyListeners();
  }

  bool isValid() {
    for (var complement in cartProdutVm!.product.complements) {
      final valid = cartProdutVm!.complementIsValid(complement);

      if (!valid) return false;
    }

    return true;
  }

  void addIem({required ItemModel item, required ComplementModel complement, required int qty}) {
    if (complement.isMultiple || qty < 1) {
      cartProdutVm!.addItem(item: item, complement: complement);
      rebuildTotal.value++;
      return;
    }
    removeItem(item: item, complement: complement);
  }

  void removeItem({required ItemModel item, required ComplementModel complement}) {
    cartProdutVm!.removeItem(item: item, complement: complement);
    rebuildTotal.value++;
  }

  void switchSize(SizeModel size) {
    cartProdutVm!.switchSize(size);
    rebuildTotal.value++;
  }

  void incrementQty() {
    cartProdutVm!.qty++;
    rebuildTotal.value++;
  }

  void decrementQty() {
    if (cartProdutVm!.qty == 1) return;
    cartProdutVm!.qty--;
    rebuildTotal.value++;
  }

  CartProductDto saveCartProduct() {
    return cartProdutVm!;
  }
}
