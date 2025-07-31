enum CulinaryStyle {
  bar,
  bistro,
  buffet,
  coffe,
  italian,
  steakHouse,
  homemadeFood,
  fastFood,
  healthyFood,
  creperie,
  arabic,
  emporium,
  supermarket,
  oriental,
  japonese,
  chinese,
  seafood,
  burguer,
  pizzeria,
  iceCream,
  bakery,
  sandwiches,
  juices,
  pharmacy;

  static CulinaryStyle fromMap(String value) {
    return CulinaryStyle.values.firstWhere((element) => element.name == value);
  }
}
