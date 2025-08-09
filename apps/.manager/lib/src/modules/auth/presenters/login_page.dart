import 'package:flutter/material.dart';

import 'package:manager/src/core/helpers/assets.dart';
import 'package:manager/src/core/helpers/breakpoints.dart';
import 'package:manager/src/core/helpers/command.dart';
import 'package:manager/src/core/helpers/routes.dart';
import 'package:manager/src/modules/auth/data/services/auth_service.dart';
import 'package:manager/src/modules/auth/presenters/components/auth_dialog_forgt_password.dart';
import 'package:manager/src/modules/auth/presenters/components/auth_login_actions_component.dart';
import 'package:manager/src/modules/auth/presenters/components/auth_login_component.dart';
import 'package:paipfood_package/paipfood_package.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailEC = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailEC.dispose();
    super.dispose();
  }

  late final authControlller = context.read<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(PImages.loginBanner), fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        PImages.logo,
                        width: 60,
                        height: 60,
                        color: Colors.white,
                      ),
                      SizedBox(height: 60),
                      RichText(
                          text: TextSpan(
                        children: [
                          TextSpan(text: 'Automatize\nas vendas\ndo seu\nRestaurante', style: context.textTheme.headlineMedium?.copyWith(color: Colors.white, fontSize: 65, height: 1.2)),
                          TextSpan(text: '.', style: context.textTheme.headlineMedium?.copyWith(color: Colors.greenAccent, fontSize: 65, height: 1.2)),
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              height: double.infinity,
              // color: Colors.black,
              child: () {
                if (PaipBreakpoint.phone.isBreakpoint(context)) {
                  return _buildPhoneLandsCape(context);
                }

                return _buildTabletPlus(context);
              }(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogin(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AuthLoginComponent(
          emailController: emailEC,
          onLogin: (email, password) async {
            Command0.executeWithLoader(
              context,
              () async {
                await authControlller.login(email: email, password: password);
              },
              analyticsDesc: 'Login',
              onSuccess: (r) {
                context.go(Routes.aparence);
              },
              onError: (e, s) {
                toast.showError(e.toString());
              },
            );
          },
        ),
        PSize.spacer.sizedBoxH,
        Align(
          alignment: Alignment.centerRight,
          child: AuthLoginActionsComponent(
            onForgotPassword: () async {
              await showDialog(
                context: context,
                builder: (context) => AuthDialogForgotPassword(
                  email: emailEC.text,
                  onSubmit: (email) async => Command0.executeWithLoader(
                    context,
                    () async {
                      Navigator.pop(context);
                      toast.showSucess('Email enviado com sucesso!', subtitle: 'Se não estiver na sua caixa de entrada, verique a caixa de spam.', duration: 30.seconds, alignment: Alignment.centerRight);
                    },
                    analyticsDesc: 'onSubmit() Dialog Forgot Password',
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTabletPlus(BuildContext context) {
    return Padding(
      padding: PSize.ii.paddingAll + PSize.v.paddingHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            context.isDarkTheme ? PImages.logoNameHorizontalDark : PImages.logoNameHorizontalLight,
            fit: BoxFit.fitHeight,
            height: 60,
          ),
          SizedBox(height: 60),
          _buildLogin(context),
        ],
      ),
    );
  }

  Widget _buildPhoneLandsCape(BuildContext context) {
    return Padding(padding: PSize.ii.paddingAll, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [_buildLogin(context)]));
  }
}
