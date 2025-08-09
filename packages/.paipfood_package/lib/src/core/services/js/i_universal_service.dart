import 'io_universal_js.dart' if (dart.library.html) 'universal_js.dart';

abstract interface class UniversalJs {
  factory UniversalJs() => getInstance();
  void callMethod(Object method, [List<dynamic>? args]);
}
