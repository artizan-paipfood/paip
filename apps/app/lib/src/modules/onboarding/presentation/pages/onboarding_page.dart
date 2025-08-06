import 'package:app/i18n/gen/strings.g.dart';
import 'package:app/src/core/utils/images.dart';
import 'package:app/src/core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.loginOnboarding),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 220,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 75),
              child: SvgPicture.asset(
                SvgImages.logoLight,
                fit: BoxFit.fitWidth,
                width: 150,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.transparent],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: PSize.ii.paddingAll,
                          child: ArtButton(
                            child: Text(t.entrar),
                            onPressed: () {
                              Go.of(context).go(Routes.authUserName);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
