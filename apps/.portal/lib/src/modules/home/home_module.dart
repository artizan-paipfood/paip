import 'dart:async';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/src/core/helpers/routes.dart';
import 'package:portal/src/modules/home/presenters/pages/home_page.dart';
import 'package:portal/src/modules/home/presenters/viewmodels/plans_viewmodel.dart';

class HomeModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.singleton((i) => PlanRepository(http: i.get())),
        Bind.singleton((i) => PlansViewmodel(planRepo: i.get())),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Routes.homeRelative,
          child: (context, state) => const HomePage(),
        ),
      ];
}
