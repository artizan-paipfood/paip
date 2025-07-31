class GenericException extends Error {
  GenericException(this.message);
  final String message;

  @override
  String toString() => message;
}
