import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/src/core/helpers/routes.dart';
import 'package:portal/src/modules/policy/presenters/pages/policy_manager_app_page.dart';

class PolicyModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Routes.policyGestorRelative,
          child: (context, args) => PolicyManagerAppPage(),
        )
      ];
}
