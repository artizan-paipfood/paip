import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/src/modules/register/register/domain/dtos/password_validation_dto.dart';

class PasswordVerifyController {
  static PasswordValidationDto verify(String value) {
    double score = 0;
    int qtyValidations = 4;
    if (Utils.rgxHasMatch(RegExp(r'[A-Z]'), value: value)) score += 1 / qtyValidations;

    if (Utils.rgxHasMatch(RegExp(r'[a-z]'), value: value)) score += 1 / qtyValidations;

    if (Utils.rgxHasMatch(RegExp(r'\d'), value: value)) score += 1 / qtyValidations;

    if (Utils.rgxHasMatch(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'), value: value)) score += 1 / qtyValidations;

    final Color color = switch (score) {
      <= 0.25 => Colors.red,
      <= 0.50 => Colors.yellow,
      <= 0.75 => PColors.secondaryColorL_,
      <= 1 => PColors.primaryColor_,
      _ => Colors.transparent,
    };

    return PasswordValidationDto(
      color: color,
      score: score,
    );
  }
}
