import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:manager/l10n/i18n_extension.dart';

extension ResetOrderNumberPeriodX on ResetOrderNumberPeriod {
  String i18n(BuildContext context) {
    switch (this) {
      case ResetOrderNumberPeriod.never:
        return context.i18n.nunca;
      case ResetOrderNumberPeriod.daily:
        return context.i18n.diariamente;
      case ResetOrderNumberPeriod.weekly:
        return context.i18n.semanalmente;
      case ResetOrderNumberPeriod.monthly:
        return context.i18n.mensalmente;
      case ResetOrderNumberPeriod.yearly:
        return context.i18n.anualmente;
    }
  }
}
