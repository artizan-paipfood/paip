import 'dart:math';
import 'package:flutter/material.dart';

class ColorsUtils {
  ColorsUtils._();
  static Color get randomColor {
    return colors[Random().nextInt(colors.length)];
  }

  static List<Color> colors = const [
    Color(0xffd50000),
    Color(0xffc51162),
    Color(0xffaa00ff),
    Color(0xffaa00ff),
    Color(0xff7c4dff),
    Color(0xff304ffe),
    Color(0xff2962ff),
    Color(0xff006064),
    Color(0xff004d40),
    Color(0xff00bfa5),
    Color(0xff00c853),
    Color(0xff00e676),
    Color(0xff76ff03),
    Color(0xff33691e),
    Color(0xffc6ff00),
    Color(0xffffd600),
    Color(0xffffab00),
    Color(0xffe65100),
    Color(0xffff6d00),
    Color(0xffdd2c00),
    Color(0xfff4511e),
  ];
}
