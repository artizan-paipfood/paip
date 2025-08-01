import 'package:app/src/core/utils/routes.dart';
import 'package:app/src/modules/onboarding/presentation/pages/onboarding_page.dart';
import 'package:core_flutter/core_flutter.dart';

class OnboardingModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Routes.onboardingRelative,
          name: Routes.onboardingNamed,
          child: (context, state) => OnboardingPage(),
        ),
      ];
}
