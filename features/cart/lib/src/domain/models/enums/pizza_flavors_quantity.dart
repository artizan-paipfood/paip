/// Enum representing the quantity of flavors allowed in a pizza
/// Follows SRP - single responsibility of defining pizza flavor quantities
enum PizzaFlavorsQuantity {
  one(1, "One Flavor"),
  two(2, "Two Flavors"),
  three(3, "Three Flavors"),
  four(4, "Four Flavors");

  const PizzaFlavorsQuantity(this.quantity, this.description);

  final int quantity;
  final String description;

  /// Creates from integer quantity
  static PizzaFlavorsQuantity fromInt(int quantity) {
    return PizzaFlavorsQuantity.values.firstWhere((e) => e.quantity == quantity, orElse: () => throw ArgumentError('Invalid pizza flavors quantity: $quantity'));
  }

  /// Gets all quantities up to this one
  List<PizzaFlavorsQuantity> get availableQuantities {
    return PizzaFlavorsQuantity.values.where((e) => e.quantity <= quantity).toList();
  }
}
