import 'dart:async';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:store/src/data/services/empty_store_redirect.dart';
import 'package:store/src/presentation/pages/search_page.dart';
import 'package:store/src/presentation/pages/store_page.dart';
import 'package:store/src/presentation/viewmodels/store_viewmodel.dart';
import 'package:store/src/utils/routes.dart';
import 'package:store/store.dart';

class StoreModule extends EventModule {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.factory((i) => ViewsApi(client: i.get())),
        Bind.singleton<StoreViewmodel>((i) => StoreViewmodel(viewsApi: i.get())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Routes.storeRelative,
          name: Routes.storeNamed,
          child: (context, state) => StorePage(
            establishmentId: state.pathParameters['establishment_id']!,
          ),
        ),
        ChildRoute(
          Routes.searchRelative,
          name: Routes.searchNamed,
          redirect: EmptyStoreRedirect.redirect,
          child: (context, state) => SearchPage(),
        ),
      ];

  @override
  void listen() {
    on<GoStoreSearch>((event, context) {
      context?.pushNamed(Routes.searchNamed, pathParameters: Routes.searchNamedParams(event.establishmentId));
    });
  }
}
