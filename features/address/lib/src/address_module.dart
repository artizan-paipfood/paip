import 'dart:async';
import 'package:address/src/presentation/pages/auto_complete_page.dart';
import 'package:address/src/presentation/pages/manually_page.dart';
import 'package:address/src/presentation/pages/my_addresses_page.dart';
import 'package:address/src/utils/routes.dart';
import 'package:core_flutter/core_flutter.dart';

class AddressModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Routes.myAddressesRelative,
          name: Routes.myAddressesNamed,
          child: (context, args) => MyAddressesPage(),
        ),
        ChildRoute(
          Routes.autoCompleteRelative,
          name: Routes.autoCompleteNamed,
          child: (context, args) => AutoCompletePage(),
        ),
        ChildRoute(
          Routes.manuallyRelative,
          name: Routes.manuallyNamed,
          child: (context, args) => ManuallyPage(),
        ),
      ];
}
