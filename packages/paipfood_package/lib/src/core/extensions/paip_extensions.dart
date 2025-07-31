import 'dart:math';

import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

// extension InterableExtension on Iterable {
//   List<Map> toMapList() => map((e) => e as Map<String, dynamic>).toList();
//   Set addToSet(dynamic value) {
//     return {...this, value};
//   }

//   Set addToSetBuild(dynamic value) {
//     return {...this, value};
//   }
// }

extension ListExtension on List {
  List<Map> toMapList() => map((e) => e as Map<String, dynamic>).toList();
  Set addToSet(dynamic value) {
    return {...this, value};
  }

  void addClone({required dynamic origin, required dynamic clone}) {
    remove(origin);
    add(clone);
  }
}

extension WidgetExtension on Widget {
  Widget get excludeFocus => ExcludeFocus(child: this);
}

extension MapExtension on Map {
  bool contains({required String key, required String value}) {
    return this[key]?.toUpperCase().contains(value.toUpperCase()) ?? false;
  }

  bool startsWith({required String key, required String value}) {
    return this[key]?.toUpperCase().startsWith(value.toUpperCase()) ?? false;
  }
}

extension NumExtension on num {
  String get toStringCurrency => "${LocaleNotifier.instance.currency} ${Utils.maskUltisToString(toStringAsFixed(2), MaskUtils.currency())}";
  double netTotalMinusTaxPercent(double taxPercent) {
    final result = this - (this / 100) * taxPercent;
    return result;
  }

  bool isInRange({required num min, required num max}) {
    final result = this >= min && this <= max;
    return result;
  }
}

extension TextStyleExtension on TextStyle {
  TextStyle muted(BuildContext context) => copyWith(color: context.color.secondaryText);
}

extension StringExtension on String {
  String i18n() {
    final i = mapI18n[this];
    return i ?? this;
  }

  String removeAccents() {
    if (!RegExp(r'[áàãâäéèêëíìîïóòõôöúùûüç]').hasMatch(this)) {
      return this;
    }

    final replacementMap = {
      'á': 'a',
      'à': 'a',
      'ã': 'a',
      'â': 'a',
      'ä': 'a',
      'é': 'e',
      'è': 'e',
      'ê': 'e',
      'ë': 'e',
      'í': 'i',
      'ì': 'i',
      'î': 'i',
      'ï': 'i',
      'ó': 'o',
      'ò': 'o',
      'õ': 'o',
      'ô': 'o',
      'ö': 'o',
      'ú': 'u',
      'ù': 'u',
      'û': 'u',
      'ü': 'u',
      'ç': 'c'
    };

    return replaceAllMapped(RegExp(r'[áàãâäéèêëíìîïóòõôöúùûüç]'), (match) {
      return replacementMap[match.group(0)] ?? match.group(0)!;
    });
  }

  // String encodePassword() {
  //   final String digitsOnly = Utils.onlyNumbersRgx(this);

  //   int sum = 0;
  //   for (int i = 0; i < digitsOnly.length; i++) {
  //     sum += int.parse(digitsOnly[i]);
  //   }

  //   final int n = (sum % 7) + 3;

  //   final text = "${Env.passwordDefault}$this";
  //   final List<String> matriz = List.filled(n, "");
  //   int rail = 0;
  //   int step = 1;
  //   for (int i = 0; i < text.length; i++) {
  //     final String c = text[i];
  //     matriz[rail] = matriz[rail] + c;
  //     if (rail == n - 1) {
  //       step = -1;
  //     } else if (rail == 0) {
  //       step = 1;
  //     }
  //     rail += step;
  //   }
  //   return matriz.join();
  // }

  String get buildPublicUriBucket => "https://pub-e6f06fb0d25440d1a5afe5f8581988b6.r2.dev/$this";

  String get toCurrency => Utils.maskUltisToString(this, MaskUtils.currency());
}

extension FutureExtension on Future<Object> {
  Future<Object> tryCatch() async {
    try {
      return await this;
    } catch (e) {
      return e.toString();
    }
  }
}

extension TextExtension on Text {
  Widget get center => Padding(padding: const EdgeInsets.only(bottom: 2), child: this);
}

extension on String {
  String get tail {
    return substring(1);
  }
}

int levenshteinDistance(String str1, String str2) {
  return str1.levenshteinDistance(str2);
}

extension StringMatcher on String {
  int levenshteinDistance(String other) {
    if (isEmpty) return other.length;
    if (other.isEmpty) return length;
    if (this[0] == other[0]) return tail.levenshteinDistance(other.tail);
    return 1 +
        <int>[
          levenshteinDistance(other.tail),
          tail.levenshteinDistance(other),
          tail.levenshteinDistance(other.tail),
        ].reduce(min);
  }
}
