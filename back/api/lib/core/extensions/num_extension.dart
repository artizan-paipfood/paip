extension BackNumExtension on num {
  int toIntAmount() {
    return (this * 100).toInt();
  }

  double transformIntAmountToDouble() {
    return this / 100;
  }
}
