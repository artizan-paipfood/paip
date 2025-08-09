import 'dart:async';
import 'package:manager/src/core/helpers/routes.dart';
import 'package:manager/src/modules/pdv/pdv_core_module.dart';
import 'package:manager/src/modules/pdv/presenter/pdv_page.dart';
import 'package:manager/src/modules/table/table_module.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PdvModule extends Module {
  @override
  FutureOr<List<Module>> imports() => [TableModule(), PdvCoreModule()];

  @override
  List<ModularRoute> get routes => [ChildRoute(Routes.pdvRelative, child: (context, args) => const PdvPage())];
}
