import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CartProductViewmodel extends ChangeNotifier {
  CartProductDto? _cartProdutVm;
  CartProductDto? get cartProdutVm => _cartProdutVm;

  void init({required ProductModel product, CartProductDto? cartProduct}) {
    if (cartProduct != null) {
      _cartProdutVm = cartProduct.clone();
      _cartProdutVm!.price = cartProduct.price / _cartProdutVm!.qty;
      return;
    }
    final SizeModel? size = product.sizes.firstWhereOrNull((element) => element.isPreSelected);
    _cartProdutVm = CartProductDto(id: uuid, product: product, itemsCartMap: {}, qtyFlavorsPizza: product.qtyFlavorsPizza, price: product.getPrice + (size?.price ?? 0), size: size);
  }

  void switchQtyFlavorPizza(QtyFlavorsPizza qtyFlavorsPizza) {
    if (_cartProdutVm?.qtyFlavorsPizza == qtyFlavorsPizza) return;
    _cartProdutVm!.switchQtyFlavorPizza(qtyFlavorsPizza);
    notifyListeners();
  }

  bool isValid() {
    for (var complement in _cartProdutVm!.product.complements) {
      final valid = _cartProdutVm!.complementIsValid(complement);

      if (!valid) return false;
    }

    return true;
  }

  void addIem({required ItemModel item, required ComplementModel complement, required int qty}) {
    if (complement.isMultiple || qty < 1) {
      _cartProdutVm!.addItem(item: item, complement: complement);
      notifyListeners();
      return;
    }
    removeItem(item: item, complement: complement);
  }

  void onChangeObservation(String value) {
    _cartProdutVm = _cartProdutVm!.copyWith(observation: value);
  }

  void removeItem({required ItemModel item, required ComplementModel complement}) {
    _cartProdutVm!.removeItem(item: item, complement: complement);
    notifyListeners();
  }

  void switchSize(SizeModel size) {
    _cartProdutVm!.switchSize(size);
    notifyListeners();
  }

  void incrementQty() {
    _cartProdutVm!.qty++;
    notifyListeners();
  }

  void decrementQty() {
    if (_cartProdutVm!.qty == 1) return;
    _cartProdutVm!.qty--;
    notifyListeners();
  }

  void _reset() {
    _cartProdutVm = null;
  }

  CartProductDto saveCartProduct() {
    final result = _cartProdutVm!.copyWith(price: _cartProdutVm!.price * _cartProdutVm!.qty);
    _reset();
    return result;
  }
}
