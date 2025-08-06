extension ValidatorExtension on String? {
  bool vIsEmpty() {
    return this == null || this!.trim().isEmpty;
  }

  bool vIsNotEmpty() {
    return !vIsEmpty();
  }

  bool vQtyMin(int min) {
    return this != null && this!.length >= min;
  }

  bool vQtyMax(int max) {
    return this != null && this!.length <= max;
  }

  bool vQtyBetween(int min, int max) {
    return this != null && this!.length >= min && this!.length <= max;
  }

  bool vIsEmail() {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this!);
  }

  bool vIsValidCEP() {
    return RegExp(r'^[0-9]{8}$').hasMatch(this!);
  }

  bool vIsValidPostCode() {
    return RegExp(r'^[0-9]{5}$').hasMatch(this!);
  }
}
