class Price {
  final double value;

  const Price._(this.value);

  /// Creates price from double value
  factory Price.fromDouble(double value) {
    if (value < 0) {
      throw ArgumentError('Price cannot be negative');
    }
    return Price._(value);
  }

  /// Creates zero price
  factory Price.zero() => const Price._(0.0);

  /// Adds two prices
  Price operator +(Price other) => Price._(value + other.value);

  /// Subtracts two prices
  Price operator -(Price other) {
    final result = value - other.value;
    if (result < 0) {
      throw ArgumentError('Result cannot be negative');
    }
    return Price._(result);
  }

  /// Multiplies price by quantity
  Price operator *(int quantity) {
    if (quantity < 0) {
      throw ArgumentError('Quantity cannot be negative');
    }
    return Price._(value * quantity);
  }

  /// Divides price
  Price operator /(int divisor) {
    if (divisor <= 0) {
      throw ArgumentError('Divisor must be positive');
    }
    return Price._(value / divisor);
  }

  /// Checks if price is greater than other
  bool operator >(Price other) => value > other.value;

  /// Checks if price is less than other
  bool operator <(Price other) => value < other.value;

  /// Checks if price is greater than or equal to other
  bool operator >=(Price other) => value >= other.value;

  /// Checks if price is less than or equal to other
  bool operator <=(Price other) => value <= other.value;

  /// Checks if price is zero
  bool get isZero => value == 0.0;

  /// Checks if price is positive
  bool get isPositive => value > 0.0;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Price && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value.toStringAsFixed(2);
}
