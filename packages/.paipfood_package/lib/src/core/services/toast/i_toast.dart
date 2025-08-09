import 'package:flutter/material.dart';

abstract class IToast {
  void showSucess(String title, {String? subtitle});
  void showInfo(String title, {String? subtitle});
  void showError(String title, {String? subtitle});
  void showCustom(String title, {String? subtitle, Color? color, Widget? icon});
}
