import 'package:cart/src/domain/models/cart_item.dart';
import 'package:cart/src/domain/models/cart_product_model.dart';
import 'package:core/core.dart';

/// Use case for removing an item from a cart product
/// Follows SRP - single responsibility of removing items from cart products
class RemoveItemFromCartProduct {
  /// Executes the use case
  CartProduct execute({required CartProduct cartProduct, required ItemEntity item, required ComplementEntity complement}) {
    print('🔥 REMOVE ITEM DEBUG:');
    print('  Item: ${item.name}');
    print('  Complement: ${complement.name}');
    print('  Complement Type: ${complement.complementType.name}');
    print('  Is Multiple: ${complement.isMultiple}');

    // Get current quantity
    final currentQuantity = cartProduct.getItemQuantity(item: item, complement: complement);
    print('  Current quantity for this item: $currentQuantity');

    if (currentQuantity == 0) {
      print('  ❌ Item not in cart, returning unchanged');
      // Item not in cart, return unchanged
      return cartProduct;
    }

    // Create new items map
    final newItemsMap = Map<String, Map<String, CartItem>>.from(cartProduct.itemsMap);

    if (currentQuantity == 1) {
      print('  🗑️ Removing item completely');
      // Remove item completely
      newItemsMap[complement.id]?.remove(item.id);

      // Remove complement map if empty
      if (newItemsMap[complement.id]?.isEmpty == true) {
        newItemsMap.remove(complement.id);
        print('  🗑️ Removed empty complement map');
      }
    } else {
      // Decrease quantity
      print('  ➖ Decreasing quantity from $currentQuantity to ${currentQuantity - 1}');
      final existingCartItem = newItemsMap[complement.id]![item.id]!;
      final updatedCartItem = existingCartItem.copyWith(quantity: currentQuantity - 1);
      newItemsMap[complement.id]![item.id] = updatedCartItem;
      print('  ✅ Updated item quantity');
    }

    return cartProduct.copyWith(itemsMap: newItemsMap);
  }
}
