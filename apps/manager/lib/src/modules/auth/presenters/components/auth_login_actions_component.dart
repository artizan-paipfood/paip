import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AuthLoginActionsComponent extends StatelessWidget {
  final void Function() onForgotPassword;

  const AuthLoginActionsComponent({required this.onForgotPassword, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onForgotPassword, child: Text(context.i18n.esqueceuSenha, style: TextStyle(color: context.color.primaryColor)));
  }
}
