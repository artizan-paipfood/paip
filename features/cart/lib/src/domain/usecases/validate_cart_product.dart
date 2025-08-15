import 'package:cart/src/domain/models/cart_product_model.dart';

/// Use case for validating a cart product
/// Follows SRP - single responsibility of validating cart products
class ValidateCartProduct {
  /// Executes the validation
  bool execute(CartProduct cartProduct) {
    // Validate all complements
    for (final complement in cartProduct.complements.values) {
      if (!cartProduct.isComplementValid(complement)) {
        return false;
      }
    }

    return true;
  }

  /// Gets validation errors for debugging
  List<String> getValidationErrors(CartProduct cartProduct) {
    final errors = <String>[];

    for (final complement in cartProduct.complements.values) {
      if (!cartProduct.isComplementValid(complement)) {
        final currentQuantity = cartProduct.getTotalQuantityForComplement(complement.id);

        if (complement.isRequired && currentQuantity == 0) {
          errors.add('${complement.name} is required');
        } else if (currentQuantity < complement.qtyMin) {
          errors.add('${complement.name} requires at least ${complement.qtyMin} items');
        }
      }
    }

    return errors;
  }
}
