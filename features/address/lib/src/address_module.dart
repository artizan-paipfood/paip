import 'dart:async';
import 'package:address/src/data/events/route_events.dart';
import 'package:address/src/domain/usecases/update_principal_user_address_usecase.dart';
import 'package:address/src/presentation/pages/auto_complete_page.dart';
import 'package:address/src/presentation/pages/address_manually_page.dart';
import 'package:address/src/presentation/pages/my_addresses_page.dart';
import 'package:address/src/presentation/pages/my_positon_page.dart';
import 'package:address/src/presentation/pages/postcode_page.dart';
import 'package:address/src/presentation/viewmodels/address_manually_viewmodel.dart';
import 'package:address/src/presentation/viewmodels/auto_complete_viewmodel.dart';
import 'package:address/src/presentation/viewmodels/my_addresses_viewmodel.dart';
import 'package:address/src/presentation/viewmodels/post_code_viewmodel.dart';
import 'package:address/src/utils/routes.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';

class AddressModule extends EventModule {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.factory((i) => IpApi(client: ClientDio())),
        Bind.factory((i) => AuthApi(client: i.get())),
        Bind.factory((i) => AddressApi(client: i.get())),
        Bind.factory((i) => UpdateUserPrincipalAddressUsecase(authApi: i.get())),
        Bind.singleton((i) => AddressManuallyViewmodel(addressApi: i.get(), updateUserPrincipalAddressUsecase: i.get())),
        Bind.singleton((i) => MyAddressesViewmodel(authApi: i.get(), addressApi: i.get())),
        Bind.singleton((i) => SearchAddressApi(client: i.get(key: PaipBindKey.paipApi))),
        Bind.singleton((i) => AutoCompleteViewmodel(searchAddressApi: i.get())),
        Bind.singleton((i) => PostCodeViewmodel(searchAddressApi: i.get())),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Routes.myAddressesRelative,
          // redirect: (context, state) => UserMeRedirectService.call(context: context, state: state),
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
          child: (context, args) => AutoCompletePage(viewmodel: Modular.get<AutoCompleteViewmodel>()),
        ),
        ChildRoute(
          Routes.manuallyRelative,
          name: Routes.manuallyNamed,
          redirect: (context, state) => _redirectLatLongNullable(context, state),
          child: (context, state) {
            final pathParams = state.uri.queryParameters;
            return AddressManuallyPage(lat: double.parse(pathParams['lat']!), lng: double.parse(pathParams['lng']!));
          },
        ),
        ChildRoute(
          Routes.postcodeRelative,
          name: Routes.postcodeNamed,
          child: (context, state) => PostcodePage(viewmodel: Modular.get()),
        ),
      ];

  String? _redirectLatLongNullable(BuildContext context, GoRouterState state) {
    final pathParams = state.uri.queryParameters;
    final lat = pathParams['lat'];
    final lng = pathParams['lng'];
    if (lat == null || lng == null) return state.namedLocation(Routes.myAddressesNamed);
    return null;
  }

  @override
  void listen() {
    //ROUTES

    on<GoAutoCompleteEvent>((event, context) {
      if (context == null) return;
      context.pushNamed(Routes.autoCompleteNamed);
    });
    on<GoPostcodeEvent>((event, context) {
      if (context == null) return;
      context.pushNamed(Routes.postcodeNamed);
    });
    on<GoMyAddressesEvent>((event, context) {
      if (context == null) return;
      context.pushNamed(Routes.myAddressesNamed);
    });
    on<GoMyPositionEvent>((event, context) {
      if (context == null) return;
      context.pushNamed(
        Routes.myPositionNamed,
        queryParameters: {
          'lat': event.lat.toString(),
          'lng': event.lng.toString(),
        },
      );
    });
    on<GoManuallyEvent>((event, context) {
      if (context == null) return;
      context.pushNamed(
        Routes.manuallyNamed,
        queryParameters: {
          'lat': event.lat.toString(),
          'lng': event.lng.toString(),
        },
      );
    });
  }
}
