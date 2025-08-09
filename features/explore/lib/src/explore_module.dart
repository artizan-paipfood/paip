import 'dart:async';
import 'package:auth/auth.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:explore/src/presentation/pages/explore_page.dart';
import 'package:explore/src/presentation/viewmodels/explore_viewmodel.dart';
import 'package:explore/src/utils/routes.dart';

class ExploreModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.singleton((i) => ExploreViewmodel()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Routes.explore,
          name: Routes.exploreNamed,
          redirect: (context, state) => UserMeRedirectService.call(context: context, state: state),
          child: (context, args) => const ExplorePage(),
        ),
      ];
}
