import 'package:cart/src/domain/models/cart_item.dart';
import 'package:cart/src/domain/models/cart_product_model.dart';
import 'package:core/core.dart';

/// Use case for adding an item to a cart product
/// Follows SRP - single responsibility of adding items to cart products
class AddItemToCartProduct {
  /// Executes the use case
  CartProduct execute({required CartProduct cartProduct, required ItemEntity item, required ComplementEntity complement}) {
    print('🔥 ADD ITEM DEBUG:');
    print('  Item: ${item.name}');
    print('  Complement: ${complement.name}');
    print('  Complement Type: ${complement.complementType.name}');
    print('  Is Multiple: ${complement.isMultiple}');
    print('  Max Quantity: ${complement.qtyMax}');

    // Check if complement allows more entries
    if (!cartProduct.complementAllowsMoreEntries(complement)) {
      print('  ❌ Complement does not allow more entries');
      throw Exception('Complement does not allow more entries');
    }

    // Calculate item price
    final itemPrice = cartProduct.calculateItemPrice(item: item, complement: complement);

    // Get current quantity
    final currentQuantity = cartProduct.getItemQuantity(item: item, complement: complement);
    print('  Current quantity for this item: $currentQuantity');

    // Create new items map
    final newItemsMap = Map<String, Map<String, CartItem>>.from(cartProduct.itemsMap);

    // Initialize complement map if needed
    if (newItemsMap[complement.id] == null) {
      newItemsMap[complement.id] = <String, CartItem>{};
    }

    // Check existing items in complement
    final existingItems = newItemsMap[complement.id]!;
    print('  Existing items in complement: ${existingItems.length}');
    for (final entry in existingItems.entries) {
      print('    - ${entry.value.item.name}: ${entry.value.quantity}x');
    }

    // Handle non-multiple complements (replace existing item)
    if (!complement.isMultiple && currentQuantity == 0) {
      print('  🚨 NON-MULTIPLE complement and item not selected - CLEARING existing items');
      if (existingItems.isNotEmpty) {
        // Remove existing item for non-multiple complements
        existingItems.clear();
        print('  ✅ Cleared existing items');
      }
    } else {
      print('  ✅ Multiple complement OR item already selected - keeping existing items');
    }

    // Add or update item
    final newQuantity = currentQuantity + 1;
    final cartItem = CartItem.fromItem(item: item, complementId: complement.id, quantity: newQuantity, unitPrice: itemPrice);

    newItemsMap[complement.id]![item.id] = cartItem;
    print('  ✅ Added/updated item: ${item.name} -> ${newQuantity}x');

    return cartProduct.copyWith(itemsMap: newItemsMap);
  }
}
