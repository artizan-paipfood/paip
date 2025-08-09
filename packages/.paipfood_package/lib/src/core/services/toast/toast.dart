import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

enum ToastType { toast, banner, sanckbar }

class Toast implements IToast {
  final BuildContext context;
  final ToastType type;
  Toast._(this.context, this.type);

  factory Toast.of(BuildContext context) {
    return Toast._(context, ToastType.toast);
  }

  @override
  void showError(String title, {String? subtitle, Alignment? alignment, Duration? duration}) =>
      _showMessage(title: title, subtitle: subtitle, color: context.color.errorColor, alignment: alignment, duration: duration, icon: const Icon(PIcons.strokeRoundedClosedCaption, color: Colors.white));

  @override
  void showInfo(String title, {String? subtitle, Alignment? alignment, Duration? duration}) => _showMessage(title: title, subtitle: subtitle, duration: duration, color: Colors.blue, alignment: alignment, icon: Icon(PIcons.strokeRoundedInformationCircle, color: Colors.white));

  @override
  void showSucess(String title, {String? subtitle, Alignment? alignment, Duration? duration}) =>
      _showMessage(title: title, subtitle: subtitle, duration: duration, color: PColors.primaryColor_, alignment: alignment, icon: const Icon(PIcons.strokeRoundedCheckmarkCircle01, color: Colors.white));
  @override
  void showCustom(String title, {String? subtitle, Color? color, Widget? icon, Alignment? alignment, Duration? duration}) =>
      _showMessage(title: title, duration: duration, subtitle: title, color: color ?? Colors.black, alignment: alignment, icon: icon ?? const Icon(PIcons.strokeRoundedInformationCircle, color: Colors.white));

  Duration calculeDuration(String message) {
    final int lenght = message.split(" ").length;
    final int miliseconds = lenght * 400;
    if (miliseconds < 4000) return const Duration(seconds: 4);
    return Duration(milliseconds: miliseconds);
  }

  void _showMessage({required String title, required Color color, String? subtitle, Widget? icon, Color? backGroundColor, Alignment? alignment, Duration? duration}) {
    toastification.show(
      context: context,
      title: Text(title, style: context.textTheme.titleMedium?.copyWith(color: Colors.white)),
      style: ToastificationStyle.fillColored,
      autoCloseDuration: duration ?? calculeDuration(title + (subtitle ?? '')),
      backgroundColor: backGroundColor ?? context.color.onPrimaryBG,
      primaryColor: color,
      foregroundColor: context.color.primaryText,
      borderRadius: BorderRadius.circular(12),
      dragToClose: true,
      alignment: alignment ?? Alignment.bottomRight,
      showProgressBar: true,
      boxShadow: [],
      description: subtitle != null ? Text(subtitle, style: context.textTheme.bodyMedium?.copyWith(color: Colors.white)) : null,
      closeButtonShowType: CloseButtonShowType.always,
      icon: icon,
      pauseOnHover: true,
      progressBarTheme: ProgressIndicatorThemeData(color: Colors.grey.shade300, linearTrackColor: Colors.white),
    );
  }
}
