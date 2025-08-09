import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PBanner implements IToast {
  final BuildContext context;

  PBanner._(this.context);

  factory PBanner.of(BuildContext context) {
    return PBanner._(context);
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
  void showSucess(String message, {String? subtitle, Duration? duration}) => _showMessage(label: subtitle ?? "Sucess", message: message, duration: duration, textColor: Colors.white, backGroundColor: context.color.primaryColor);
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
    final int miliseconds = lenght * 200;
    if (miliseconds < 1000) return const Duration(seconds: 1);
    return Duration(milliseconds: miliseconds > 3000 ? miliseconds : 3000);
  }

  void _showMessage({required String label, required String message, required Color textColor, Widget? icon, Color? backGroundColor, Alignment? alignment, Duration? duration}) {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(
          message,
          style: context.textTheme.titleMedium?.copyWith(color: textColor),
          textAlign: TextAlign.center,
        ),
        margin: EdgeInsets.zero,
        leading: icon,
        backgroundColor: backGroundColor,
        dividerColor: textColor.withOpacity(0.30),
        actions: const <Widget>[
          SizedBox()
        ],
      ),
    );
    Future.delayed(duration ?? calculeDuration(message), () {
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      }
    });
  }
}
