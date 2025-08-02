import 'dart:async';
import 'package:address/src/presentation/pages/auto_complete_page.dart';
import 'package:address/src/presentation/pages/manually_page.dart';
import 'package:address/src/presentation/pages/my_addresses_page.dart';
import 'package:address/src/presentation/pages/my_positon_page.dart';
import 'package:address/src/presentation/viewmodels/my_addresses_viewmodel.dart';
import 'package:address/src/utils/routes.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';

class AddressModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.singleton((i) => MyAddressesViewmodel()),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Routes.myAddressesRelative,
          name: Routes.myAddressesNamed,
          child: (context, args) => MyAddressesPage(),
        ),
        ChildRoute(
          Routes.myPositionRelative,
          name: Routes.myPositionNamed,
          redirect: (context, state) => _redirectLatLongNullable(context, state),
          child: (context, state) {
            final pathParams = state.uri.queryParameters;
            return MyPositonPage(lat: double.parse(pathParams['lat']!), lng: double.parse(pathParams['lng']!));
          },
        ),
        ChildRoute(
          Routes.autoCompleteRelative,
          name: Routes.autoCompleteNamed,
          child: (context, args) => AutoCompletePage(),
        ),
        ChildRoute(
          Routes.manuallyRelative,
          name: Routes.manuallyNamed,
          redirect: (context, state) => _redirectLatLongNullable(context, state),
          child: (context, state) {
            final pathParams = state.uri.queryParameters;
            return ManuallyPage(lat: double.parse(pathParams['lat']!), lng: double.parse(pathParams['lng']!));
          },
        ),
      ];

  String? _redirectLatLongNullable(BuildContext context, GoRouterState state) {
    final pathParams = state.uri.queryParameters;
    final lat = pathParams['lat'];
    final lng = pathParams['lng'];
    if (lat == null || lng == null) return state.namedLocation(Routes.myAddressesNamed);
    return null;
  }
}
