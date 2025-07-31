import 'package:manager/src/core/helpers/routes.dart';
import 'package:manager/src/modules/reports/presenters/pages/order_reports_page.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ReportsModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(Routes.reportsRelative, child: (context, args) => const OrderReportsPage()),
      ];
}
