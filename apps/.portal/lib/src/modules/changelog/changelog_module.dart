import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/src/core/helpers/routes.dart';
import 'package:portal/src/modules/changelog/presenters/pages/changelog_page.dart';

class ChangelogModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Routes.changelogRelative,
          child: (context, state) => ChangelogPage(project: state.pathParameters[Routes.changelogProjectParam]!),
        )
      ];
}
