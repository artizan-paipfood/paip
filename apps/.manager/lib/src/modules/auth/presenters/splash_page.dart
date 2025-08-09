import 'package:flutter/material.dart';

import 'package:i18n/i18n.dart';
import 'package:manager/src/core/helpers/assets.dart';
import 'package:manager/src/core/helpers/routes.dart';
import 'package:manager/src/modules/auth/data/services/auth_service.dart';
import 'package:manager/src/modules/auth/data/usecases/auth_process_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    load();
    super.initState();
  }

  Future<void> load() async {
    if (AppI18n.instance.userHasSetLanguage == false && context.mounted) return context.go(Routes.selectLanguage);
    await AuthProcessUsecase(context: context, authService: context.read<AuthService>()).call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 300,
          width: 400,
          child: SvgPicture.asset(context.isDarkTheme ? PImages.logoNameVerticalDark : PImages.logoNameVerticalLight),
        ).animate(onPlay: (controller) => controller.repeat()).moveY(begin: -10, end: 25, curve: Curves.easeInOut, duration: 1000.ms).then().moveY(begin: 25, end: -10, curve: Curves.easeInOut),
        //
      ),
    );
  }
}
