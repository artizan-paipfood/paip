import 'package:cart/src/domain/models/cart_product_model.dart';
import 'package:cart/src/domain/usecases/add_item_to_cart_product.dart';
import 'package:cart/src/domain/usecases/remove_item_from_cart_product.dart';
import 'package:cart/src/domain/usecases/validate_cart_product.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

class CartProductViewmodel extends ChangeNotifier {
  final ViewsApi viewsApi;
  final AddItemToCartProduct addItemToCartProduct;
  final RemoveItemFromCartProduct removeItemFromCartProduct;
  final ValidateCartProduct validateCartProduct;

  CartProductViewmodel({required this.viewsApi, required this.addItemToCartProduct, required this.removeItemFromCartProduct, required this.validateCartProduct});

  final ValueNotifier<bool> _isLoading = ValueNotifier(true);

  ValueNotifier<bool> get load => _isLoading;

  CartProduct? _cartProduct;

  ProductEntity? get product => _cartProduct?.product;

  Future<void> initialize(String productId) async {
    _isLoading.value = true;
    final view = await viewsApi.getProductView(productId: productId);
    _cartProduct = CartProduct.fromProductView(view: view!);
    _isLoading.value = false;
  }

  List<ComplementEntity> get complements => _cartProduct?.complements.values.toList() ?? [];

  void addItemToCart(String complementId, String itemId) {
    final item = _cartProduct!.items[itemId]!;
    final complement = _cartProduct!.complements[complementId]!;
    _cartProduct = addItemToCartProduct.execute(cartProduct: _cartProduct!, item: item, complement: complement);
    notifyListeners();
  }

  void removeItemFromCart(String complementId, String itemId) {
    final item = _cartProduct!.items[itemId]!;
    final complement = _cartProduct!.complements[complementId]!;
    _cartProduct = removeItemFromCartProduct.execute(cartProduct: _cartProduct!, item: item, complement: complement);
    notifyListeners();
  }

  bool validateCart() {
    return validateCartProduct.execute(_cartProduct!);
  }

  List<String> getValidationErrors() {
    return validateCartProduct.getValidationErrors(_cartProduct!);
  }

  List<ItemEntity> getItemsByComplement(String complementId) {
    return _cartProduct!.items.values.where((item) => item.complementId == complementId).toList();
  }

  int getComplementQtySelected(String complementId) {
    return _cartProduct!.getTotalQuantityForComplement(complementId);
  }
}
