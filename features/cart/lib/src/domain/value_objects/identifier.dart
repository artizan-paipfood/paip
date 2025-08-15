import 'package:core/core.dart';

class Identifier {
  final String value;

  const Identifier._(this.value);

  factory Identifier.fromString(String value) {
    if (value.isEmpty) {
      throw ArgumentError('Identifier cannot be empty');
    }
    return Identifier._(value);
  }

  factory Identifier.generate() {
    return Identifier._(const Uuid().v4());
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is Identifier && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
