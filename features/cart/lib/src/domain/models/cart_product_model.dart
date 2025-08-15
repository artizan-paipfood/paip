import 'package:cart/src/domain/models/cart_item.dart';
import 'package:cart/src/domain/models/enums/pizza_flavors_quantity.dart';
import 'package:cart/src/domain/value_objects/price.dart';
import 'package:core/core.dart';

/// Entity representing a product in the cart with its customizations
/// Follows SRP - single responsibility of managing cart product data and operations
class CartProduct {
  final String id;
  final ProductEntity product;
  final Map<String, ComplementEntity> complements;
  final Map<String, ItemEntity> items;
  final Map<String, SizeEntity> sizes;
  final SizeEntity? selectedSize;
  final String observation;
  final int quantity;
  final Price basePrice;
  final PizzaFlavorsQuantity? pizzaFlavorsQuantity;
  final Map<String, Map<String, CartItem>> itemsMap;

  const CartProduct({
    required this.id,
    required this.product,
    required this.complements,
    required this.items,
    required this.sizes,
    required this.itemsMap,
    required this.observation,
    required this.quantity,
    required this.basePrice,
    this.selectedSize,
    this.pizzaFlavorsQuantity,
  });

  /// Factory to create from product
  factory CartProduct.fromProductView({required ProductView view}) {
    return CartProduct(
      id: Uuid().v4(),
      product: view.product,
      complements: view.complements,
      items: view.items,
      sizes: view.sizes,
      itemsMap: {},
      observation: '',
      quantity: 1,
      basePrice: Price.fromDouble(view.product.finalPrice),
    );
  }

  /// Gets total price including all customizations
  Price get totalPrice => (basePrice + customizationsPrice) * quantity;

  /// Gets price of all customizations
  Price get customizationsPrice {
    Price total = Price.zero();
    for (final complementItems in itemsMap.values) {
      for (final cartItem in complementItems.values) {
        total = total + cartItem.totalPrice;
      }
    }
    return total;
  }

  /// Gets quantity of items for a specific complement
  int getQuantityForComplement(ComplementEntity complement) {
    return itemsMap[complement.id]?.length ?? 0;
  }

  /// Checks if contains a specific item in a complement
  bool containsItem({required ComplementEntity complement, required ItemEntity item}) {
    return itemsMap[complement.id]?.containsKey(item.id) ?? false;
  }

  /// Gets quantity of a specific item in a complement
  int getItemQuantity({required ItemEntity item, required ComplementEntity complement}) {
    return itemsMap[complement.id]?[item.id]?.quantity ?? 0;
  }

  /// Gets items for a specific complement
  List<ItemEntity> getItemsForComplement(ComplementEntity complement) {
    if (itemsMap[complement.id] == null) return [];
    return itemsMap[complement.id]!.values.map((cartItem) => items[cartItem.itemId]!).toList();
  }

  /// Gets cart items for a specific complement
  List<CartItem> getCartItemsForComplement(ComplementEntity complement) {
    if (itemsMap[complement.id] == null) return [];
    return itemsMap[complement.id]!.values.toList();
  }

  /// Gets all complements that have items selected
  List<ComplementEntity> getSelectedComplements() {
    return complements.values.where((complement) => itemsMap[complement.id] != null && itemsMap[complement.id]!.isNotEmpty).toList();
  }

  /// Gets total quantity of items for a complement
  int getTotalQuantityForComplement(String complementId) {
    final items = itemsMap[complementId]?.values.toList() ?? [];
    return items.fold(0, (sum, cartItem) => sum + cartItem.quantity);
  }

  /// Checks if complement allows more entries
  bool complementAllowsMoreEntries(ComplementEntity complement) {
    double maxAllowed = complement.qtyMax;
    if (complement.complementType == ComplementType.pizza && pizzaFlavorsQuantity != null) {
      maxAllowed = pizzaFlavorsQuantity!.quantity.toDouble();
    }

    final currentQuantity = getTotalQuantityForComplement(complement.id);
    return currentQuantity < (maxAllowed == 0 ? 999 : maxAllowed);
  }

  /// Checks if a specific item can be added to complement (considering pizza flavor rules)
  bool canAddItem({required ItemEntity item, required ComplementEntity complement}) {
    // For pizza flavors, check if there's room for more flavors total
    if (complement.complementType == ComplementType.pizza) {
      return complementAllowsMoreEntries(complement);
    }

    // For regular complements, check if there's room for more entries
    return complementAllowsMoreEntries(complement);
  }

  /// Gets the number of different flavors selected (for pizza)
  int getNumberOfDifferentFlavors(ComplementEntity complement) {
    if (complement.complementType != ComplementType.pizza) return 0;
    return itemsMap[complement.id]?.length ?? 0;
  }

  /// Validates if complement meets minimum requirements
  bool isComplementValid(ComplementEntity complement) {
    if (complement.complementType == ComplementType.pizza && pizzaFlavorsQuantity != null) {
      // For pizza, check if we have the required total quantity of flavors
      final totalQuantity = getTotalQuantityForComplement(complement.id);
      return totalQuantity >= pizzaFlavorsQuantity!.quantity;
    }

    if (complement.qtyMin < 1) return true;
    return getTotalQuantityForComplement(complement.id) >= complement.qtyMax;
  }

  SizeEntity? _getSizeByProductId(String productId) {
    return sizes.values.firstWhereOrNull((size) => size.productId == productId);
  }

  /// Calculates item price considering complement type and pizza flavors
  Price calculateItemPrice({required ItemEntity item, required ComplementEntity complement}) {
    Price itemPrice = Price.fromDouble(item.finalPrice);

    // Para complementos de pizza, o preço do sabor é dividido pela quantidade total de sabores permitidos
    if (complement.complementType == ComplementType.pizza && pizzaFlavorsQuantity != null) {
      // Busca o preço específico do size atrelado ao produto
      final productPrice = _getSizeByProductId(product.id);
      final dividedPrice = (productPrice?.finalPrice ?? 0) / pizzaFlavorsQuantity!.quantity;
      itemPrice = Price.fromDouble(dividedPrice);

      print('🍕 PIZZA PRICE CALCULATION:');
      print('  Item: ${item.name}');
      print('  Product: ${product.name}');
      print('  Price from size for this product: R\$ ${productPrice?.finalPrice.toStringAsFixed(2)}');
      print('  Item base price: R\$ ${item.finalPrice.toStringAsFixed(2)}');
      print('  Pizza flavors quantity: ${pizzaFlavorsQuantity!.quantity}');
      print('  Final divided price: R\$ ${dividedPrice.toStringAsFixed(2)}');

      // Debug: mostrar se encontrou o size específico
      final size = _getSizeByProductId(product.id);
      if (size != null) {
        print('  ✅ Found specific size for product: ${size.name} - R\$ ${size.finalPrice.toStringAsFixed(2)}');
      } else {
        print('  ⚠️ No specific size found, using item base price');
      }
    } else {
      print('🍽️ REGULAR ITEM PRICE:');
      print('  Item: ${item.name}');
      print('  Price: R\$ ${itemPrice.value.toStringAsFixed(2)}');
    }

    return itemPrice;
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is CartProduct && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'CartProduct(id: $id, product: ${product.name}, quantity: $quantity)';

  CartProduct copyWith({
    String? id,
    ProductEntity? product,
    Map<String, ComplementEntity>? complements,
    Map<String, ItemEntity>? items,
    Map<String, SizeEntity>? sizes,
    SizeEntity? selectedSize,
    String? observation,
    int? quantity,
    Price? basePrice,
    PizzaFlavorsQuantity? pizzaFlavorsQuantity,
    Map<String, Map<String, CartItem>>? itemsMap,
  }) {
    return CartProduct(
      id: id ?? this.id,
      product: product ?? this.product,
      complements: complements ?? this.complements,
      items: items ?? this.items,
      sizes: sizes ?? this.sizes,
      selectedSize: selectedSize ?? this.selectedSize,
      observation: observation ?? this.observation,
      quantity: quantity ?? this.quantity,
      basePrice: basePrice ?? this.basePrice,
      pizzaFlavorsQuantity: pizzaFlavorsQuantity ?? this.pizzaFlavorsQuantity,
      itemsMap: itemsMap ?? this.itemsMap,
    );
  }
}
