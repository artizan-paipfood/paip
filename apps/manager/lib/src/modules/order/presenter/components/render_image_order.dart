import 'package:flutter/material.dart';
import 'package:thermal_printer_flutter/thermal_printer_flutter.dart';
import 'package:image/image.dart' as img;

RenderImageOrder? _renderImageOrder;

RenderImageOrder get renderImageOrder {
  assert(_renderImageOrder != null, """Add RenderImageProvider.builder in your MaterialApp;
       return MaterialApp(
         builder: RenderImageProvider.builder,
         ...
  """);
  return _renderImageOrder!;
}

class RenderImageOrder {
  BuildContext context;
  RenderImageOrder._({required this.context});

  factory RenderImageOrder.of(BuildContext context) {
    return RenderImageOrder._(context: context);
  }

  Future<img.Image> buildImageOrder({
    required Widget child,
    required bool mirror,
    required double textScaleFactor,
    int? numberColumns,
  }) async {
    return await ThermalPrinterFlutter().screenShotWidget(context, widget: child, width: numberColumns ?? 550, textScaleFactor: textScaleFactor);
  }
}

class RenderImageProvider {
  static Widget builder(BuildContext context, Widget? child) {
    return Overlay(initialEntries: [
      OverlayEntry(builder: (context) {
        return _BuildListener(
          child: child ?? const SizedBox.shrink(),
        );
      }),
    ]);
  }
}

class _BuildListener extends StatelessWidget {
  final Widget child;
  const _BuildListener({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    _renderImageOrder = RenderImageOrder.of(context);
    return child;
  }
}
