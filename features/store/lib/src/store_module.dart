import 'dart:async';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:store/src/presentation/pages/store_page.dart';
import 'package:store/src/presentation/viewmodels/store_viewmodel.dart';
import 'package:store/src/utils/routes.dart';

class StoreModule extends Module {
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
      ];
}
