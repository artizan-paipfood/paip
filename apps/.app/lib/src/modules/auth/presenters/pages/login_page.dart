import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/core/helpers/assets.dart';

import 'package:app/src/core/helpers/routes.dart';
import 'package:paipfood_package/paipfood_package.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: context.color.onPrimaryBG,
        body: Stack(
          children: [
            Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage(PImages.login), fit: BoxFit.cover))),
            Container(
              height: 220,
              width: context.w * 1,
              decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black, Colors.transparent])),
              child: Align(alignment: Alignment.topLeft, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40), child: SizedBox(height: 100, width: 100, child: SvgPicture.asset(PImages.logoDark, fit: BoxFit.cover)))),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 300,
                decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Colors.black, Colors.transparent])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: PSize.ii.paddingAll,
                            child: PButton(
                              label: context.i18n.entrar.toUpperCase(),
                              onPressed: () {
                                Go.of(context).go(Routes.company(slug: 'paipfood'));
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
      ),
    );
  }
}
