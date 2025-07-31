// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CustomOverlay extends StatelessWidget {
  final Widget? child;
  final bool onWillPop;
  final Color overlayColor;
  final Alignment overlayAlignment;
  final bool fullScreen;
  static OverlayEntry? _overlayEntry;

  const CustomOverlay({
    super.key,
    this.child,
    this.onWillPop = true,
    this.overlayColor = Colors.black54,
    this.overlayAlignment = Alignment.center,
    this.fullScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return onWillPop;
      },
      child: Center(
        child: child ?? const CircularProgressIndicator(),
      ),
    );
  }

  static void show(
    BuildContext context, {
    Widget? child,
    bool onWillPop = true,
    Color overlayColor = Colors.black54,
    Alignment overlayAlignment = Alignment.center,
    bool fullScreen = false,
  }) {
    hide(); // Hide any existing overlay before showing a new one

    _overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return Stack(
        children: <Widget>[
          if (fullScreen) // Add overlay only if not fullscreen
            _buildOverlayWidget(overlayColor),
          Align(
            alignment: overlayAlignment,
            child: child ?? const CircularProgressIndicator(),
          ),
        ],
      );
    });

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hide() {
    if (_overlayEntry != null) {
      try {
        _overlayEntry?.remove();
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        _overlayEntry = null;
      }
    }
  }

  static Widget _buildOverlayWidget(Color overlayColor) {
    return Positioned.fill(
      child: Container(color: overlayColor),
    );
  }
}
