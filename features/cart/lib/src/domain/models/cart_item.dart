import 'package:cart/src/domain/models/enums/pizza_flavors_quantity.dart';
import 'package:cart/src/domain/value_objects/price.dart';
import 'package:core/core.dart';

/// Entity representing an item in the cart
/// Follows SRP - single responsibility of representing cart item data
class CartItem {
  final String id;
  final ItemEntity item;
  final String? complementId;
  final int quantity;
  final Price unitPrice;

  const CartItem({required this.id, required this.item, required this.quantity, required this.unitPrice, this.complementId});

  /// Factory to create from item and complement
  factory CartItem.fromItem({required ItemEntity item, required String complementId, required int quantity, required Price unitPrice}) {
    return CartItem(id: Uuid().v4(), item: item, complementId: complementId, quantity: quantity, unitPrice: unitPrice);
  }

  /// Gets total price for this cart item
  Price get totalPrice => unitPrice * quantity;

  /// Gets description for display
  String getDescription({PizzaFlavorsQuantity? pizzaFlavorsQuantity}) {
    if (item.itemType.name == 'pizza' && pizzaFlavorsQuantity != null) {
      return "$quantity/${pizzaFlavorsQuantity.quantity} - ${item.name}";
    }
    return "${quantity}x ${item.name}";
  }

  /// Creates a copy with changes
  CartItem copyWith({String? id, ItemEntity? item, String? complementId, int? quantity, Price? unitPrice}) {
    return CartItem(id: id ?? this.id, item: item ?? this.item, complementId: complementId ?? this.complementId, quantity: quantity ?? this.quantity, unitPrice: unitPrice ?? this.unitPrice);
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is CartItem && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'CartItem(id: $id, item: ${item.name}, quantity: $quantity)';
}
