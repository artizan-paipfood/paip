import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PSnackBar implements IToast {
  final BuildContext context;

  PSnackBar._(this.context);

  factory PSnackBar.of(BuildContext context) {
    return PSnackBar._(context);
  }

  @override
  void showError(String message, {String? subtitle, Duration? duration}) => _showMessage(
        label: subtitle ?? "Error",
        message: message,
        textColor: Colors.white,
        backGroundColor: Colors.red.shade700,
        duration: duration,
      );

  @override
  void showInfo(String message, {String? subtitle, Duration? duration}) => _showMessage(
        label: subtitle ?? "Info",
        message: message,
        duration: duration,
        backGroundColor: context.color.black,
        textColor: context.color.white,
      );

  @override
  void showSucess(String message, {String? subtitle, Duration? duration}) => _showMessage(
      label: subtitle ?? "Sucess", message: message, duration: duration, textColor: Colors.white, backGroundColor: context.color.primaryColor);
  @override
  void showCustom(String message, {String? subtitle, Color? color, Widget? icon, Alignment? alignment, Duration? duration}) => _showMessage(
        label: subtitle ?? "Custom",
        duration: duration,
        message: message,
        textColor: color ?? context.color.black,
        alignment: alignment,
        icon: icon ?? const Icon(PIcons.strokeRoundedInformationCircle, color: Colors.black),
      );

  Duration calculeDuration(String message) {
    final int lenght = message.split(" ").length;
    final int miliseconds = lenght * 400;
    if (miliseconds < 4000) return const Duration(seconds: 4);
    return Duration(milliseconds: miliseconds);
  }

  void _showMessage(
      {required String label,
      required String message,
      required Color textColor,
      Widget? icon,
      Color? backGroundColor,
      Alignment? alignment,
      Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // padding: PSize.ii.paddingAll,
        content: Text(
          message,
          style: context.textTheme.titleMedium?.copyWith(color: textColor),
          textAlign: TextAlign.center,
        ),

        backgroundColor: backGroundColor,

        // action: const <Widget>[SizedBox()],
      ),
    );
    Future.delayed(duration ?? calculeDuration(message), () {
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      }
    });
  }
}
