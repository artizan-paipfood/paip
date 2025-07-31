extension NormalizePath on String {
  String normalizePath() {
    return replaceAll(RegExp(r'/{2,}'), '/');
  }
}
