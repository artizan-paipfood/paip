import 'dart:async';
import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/company/presenters/pages/company_page.dart';
import 'package:app/src/modules/company/presenters/viewmodels/company_page_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CompanyModule extends Module {
  @override
  FutureOr<List<Bind<Object>>> binds() => [
        Bind.factory((i) => EstablishmentRepository(http: i.get())),
        Bind.factory((i) => CompanyPageViewmodel(repository: i.get())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Routes.companyRelative,
            child: (context, state) => CompanyPage(
                  slug: state.pathParameters[Routes.slugParam]!,
                )),
      ];
}
