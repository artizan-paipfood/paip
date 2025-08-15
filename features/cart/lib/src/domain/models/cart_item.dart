import 'package:cart/src/domain/models/enums/pizza_flavors_quantity.dart';
import 'package:cart/src/domain/value_objects/price.dart';
import 'package:core/core.dart';

/// Entity representing an item in the cart
/// Follows SRP - single responsibility of representing cart item data
class CartItem {
  final String id;
  final String itemId;
  final ItemType itemType;
  final String itemName;
  final String? complementId;
  final int quantity;
  final Price unitPrice;

  const CartItem({required this.id, required this.itemId, required this.itemType, required this.itemName, required this.quantity, required this.unitPrice, this.complementId});

  /// Factory to create from item and complement
  factory CartItem.fromItem({required ItemEntity item, required String complementId, required int quantity, required Price unitPrice}) {
    return CartItem(id: Uuid().v4(), itemId: item.id, itemType: item.itemType, itemName: item.name, complementId: complementId, quantity: quantity, unitPrice: unitPrice);
  }

  /// Gets total price for this cart item
  Price get totalPrice => unitPrice * quantity;

  /// Gets description for display
  String getDescription({PizzaFlavorsQuantity? pizzaFlavorsQuantity}) {
    if (itemType == ItemType.pizza && pizzaFlavorsQuantity != null) {
      return "$quantity/${pizzaFlavorsQuantity.quantity} - $itemName";
    }
    return "${quantity}x $itemName";
  }

  /// Creates a copy with changes
  CartItem copyWith({
    String? id,
    String? itemId,
    ItemType? itemType,
    String? itemName,
    String? complementId,
    int? quantity,
    Price? unitPrice,
  }) {
    return CartItem(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      itemType: itemType ?? this.itemType,
      itemName: itemName ?? this.itemName,
      complementId: complementId ?? this.complementId,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is CartItem && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'CartItem(id: $id, itemId: $itemId, itemType: $itemType, itemName: $itemName, quantity: $quantity)';
}
