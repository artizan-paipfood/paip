import 'package:paipfood_package/src/core/services/js/i_universal_service.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

UniversalJs getInstance() => WebUniversalJs();

class WebUniversalJs implements UniversalJs {
  @override
  void callMethod(Object method, [List? args]) {
    if (args != null) {
      js.context.callMethod(method, args);
    } else {
      js.context.callMethod(method);
    }
  }
}
