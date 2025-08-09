// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PasswordValidationDto {
  double score;
  Color color;
  String description;
  PasswordValidationDto({
    this.score = 0.0,
    this.color = Colors.transparent,
    this.description = '',
  });

  @override
  String toString() => 'PasswordVerifyVM(score: $score, color: $color, description: $description)';
}
