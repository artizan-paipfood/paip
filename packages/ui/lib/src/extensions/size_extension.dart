// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/widgets.dart';

/// Variables Fibonacci:
/// [none] = 0;
/// [spacer] = 21;
/// [i] = 3;
/// [ii] = 8;
/// [iii] = 13;
/// [iv] = 21;
/// [v] = 34;
/// [vi] = 55;
/// [vii] = 89;
/// [viii] = 144;

class PSize {
  PSize._();
  static double none = 0;
  static double i = 3;
  static double ii = 8;
  static double iii = 13;
  static double iv = 21;
  static double spacer = 21;
  static double v = 34;
  static double vi = 55;
  static double vii = 89;
  static double viii = 144;
}

const double _spacerValue = 1;

extension ExtensionFromDouble on double {
  double get value => this * _spacerValue;

  SizedBox get sizedBoxH => SizedBox(height: _spacerValue * this);
  SizedBox get sizedBoxW => SizedBox(width: _spacerValue * this);
  SizedBox get sizedBoxHW => SizedBox(height: _spacerValue * this, width: _spacerValue * this);

  EdgeInsets get paddingLeft => EdgeInsets.fromLTRB(_spacerValue * this, 0, 0, 0);
  EdgeInsets get paddingTop => EdgeInsets.fromLTRB(0, _spacerValue * this, 0, 0);
  EdgeInsets get paddingRight => EdgeInsets.fromLTRB(0, 0, _spacerValue * this, 0);
  EdgeInsets get paddingBottom => EdgeInsets.fromLTRB(0, 0, 0, _spacerValue * this);
  EdgeInsets get paddingHorizontal => EdgeInsets.symmetric(horizontal: _spacerValue * this);
  EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: _spacerValue * this);
  EdgeInsets get paddingAll => EdgeInsets.all(_spacerValue * this);

  BorderRadius get borderRadiusTopLeft => BorderRadius.only(topLeft: Radius.circular(_spacerValue * this));
  BorderRadius get borderRadiusTopRight => BorderRadius.only(topRight: Radius.circular(_spacerValue * this));
  BorderRadius get borderRadiusBottomLeft => BorderRadius.only(bottomLeft: Radius.circular(_spacerValue * this));
  BorderRadius get borderRadiusBottomRight => BorderRadius.only(bottomRight: Radius.circular(_spacerValue * this));
  BorderRadius get borderRadiusAll => BorderRadius.all(Radius.circular(_spacerValue * this));
}
