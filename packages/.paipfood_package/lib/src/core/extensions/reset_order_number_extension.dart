import 'package:flutter/widgets.dart';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

extension ResetOrderNumberExtension on ResetOrderNumberPeriod {
  String i18n(BuildContext context) {
    return switch (this) {
      ResetOrderNumberPeriod.never => context.i18nCore.nunca,
      ResetOrderNumberPeriod.daily => context.i18nCore.diario,
      ResetOrderNumberPeriod.weekly => context.i18nCore.semanal,
      ResetOrderNumberPeriod.monthly => context.i18nCore.mensal,
      ResetOrderNumberPeriod.yearly => context.i18nCore.anual,
    };
  }
}
