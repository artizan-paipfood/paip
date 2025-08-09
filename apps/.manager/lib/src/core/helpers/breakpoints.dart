import 'package:flutter_breakpoints/flutter_breakpoints.dart';

class PaipBreakpoint {
  PaipBreakpoint._();

  static FlutterBreakpoint phone = const FlutterBreakpoint(name: 'phone', minWidth: 0);
  static FlutterBreakpoint tablet = const FlutterBreakpoint(name: 'tablet', minWidth: 850);
  static FlutterBreakpoint desk = const FlutterBreakpoint(name: 'desk', minWidth: 1080);
  static List<FlutterBreakpoint> get breakpoints => [
        phone,
        tablet,
        desk,
      ];
}
