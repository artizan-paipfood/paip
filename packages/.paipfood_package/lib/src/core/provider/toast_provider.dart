import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:paipfood_package/src/core/services/toast/banner.dart';
import 'package:paipfood_package/src/core/services/toast/snack_bar.dart';

Toast? _toast;

Toast get toast {
  assert(_toast != null, """Add ToastProvider.builder in your MaterialApp;
       return MaterialApp(
         builder: ToastProvider.builder,
         ...
  """);
  return _toast!;
}

PBanner? _banner;

PBanner get banner {
  assert(_banner != null, """Add ToastProvider.builder in your MaterialApp;
       return MaterialApp(
         builder: ToastProvider.builder,
         ...
  """);
  return _banner!;
}

PSnackBar? _snackBar;

PSnackBar get snackBar {
  assert(_snackBar != null, """Add ToastProvider.builder in your MaterialApp;
       return MaterialApp(
         builder: ToastProvider.builder,
         ...
  """);
  return _snackBar!;
}

class ToastProvider {
  static Widget builder(BuildContext context, Widget? child) {
    return Scaffold(
      body: Overlay(initialEntries: [
        OverlayEntry(builder: (context) {
          return _BuildListener(
            child: child ?? const SizedBox.shrink(),
          );
        }),
      ]),
    );
  }
}

class _BuildListener extends StatelessWidget {
  final Widget child;
  const _BuildListener({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    _toast = Toast.of(context);
    _banner = PBanner.of(context);
    _snackBar = PSnackBar.of(context);
    return child;
  }
}
