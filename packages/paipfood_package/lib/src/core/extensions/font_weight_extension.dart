import 'dart:ui';

extension FontWeightExtension on FontWeight {
  String get name => switch (this) {
        FontWeight.w100 => 'w100',
        FontWeight.w200 => 'w200',
        FontWeight.w300 => 'w300',
        FontWeight.w400 => 'normal',
        FontWeight.w500 => 'w500',
        FontWeight.w600 => 'w600',
        FontWeight.w700 => 'bold',
        FontWeight.w800 => 'w800',
        FontWeight.w900 => 'w900',
        _ => 'unknown',
      };

  static FontWeight fromName(String name) => switch (name) {
        'w100' => FontWeight.w100,
        'w200' => FontWeight.w200,
        'w300' => FontWeight.w300,
        'normal' => FontWeight.w400,
        'w500' => FontWeight.w500,
        'w600' => FontWeight.w600,
        'bold' => FontWeight.w700,
        'w800' => FontWeight.w800,
        'w900' => FontWeight.w900,
        _ => FontWeight.normal,
      };

  FontWeight multiply(int multiplier) {
    final weights = [
      FontWeight.w100,
      FontWeight.w200,
      FontWeight.w300,
      FontWeight.w400,
      FontWeight.w500,
      FontWeight.w600,
      FontWeight.w700,
      FontWeight.w800,
      FontWeight.w900,
    ];

    final newIndex = (index + multiplier).clamp(0, weights.length - 1);

    if (newIndex >= weights.length) return weights.last;

    return weights[newIndex];
  }
}
