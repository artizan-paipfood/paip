import 'package:flutter/material.dart';
import 'package:app/src/core/helpers/assets.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // context.read<AuthStore>().checkLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 300,
          width: 400,
          child: SvgPicture.asset(context.isDarkTheme ? PImages.logoDark : PImages.logoDark),
        )
            .animate(
              onPlay: (controller) => controller.repeat(),
            )
            .moveY(begin: -10, end: 25, curve: Curves.easeInOut, duration: 1000.ms)
            .then()
            .moveY(begin: 25, end: -10, curve: Curves.easeInOut)
        //
        ,
      ),
    );
  }
}
