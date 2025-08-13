import 'package:app/src/core/utils/routes.dart';
import 'package:app/src/modules/onboarding/presentation/pages/onboarding_page.dart';
import 'package:auth/auth.dart';
import 'package:core_flutter/core_flutter.dart';

class OnboardingModule extends EventModule {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Routes.onboardingRelative,
          name: Routes.onboardingNamed,
          child: (context, state) => OnboardingPage(),
        ),
      ];

  @override
  void listen() {
    on<RequestSilentAuthentication>(
      (event, context) async {
        ModularLoader.show();
        final me = await Modular.get<SilentAuthentication>().auth();
        ModularLoader.hide();
        if (me != null) context?.go(event.redirectTo);
      },
    );
  }
}
