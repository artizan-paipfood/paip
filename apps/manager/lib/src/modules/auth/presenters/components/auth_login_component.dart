import 'package:artizan_ui/artizan_ui.dart';
import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

import 'package:manager/l10n/i18n_extension.dart';

class AuthLoginComponent extends StatefulWidget {
  final TextEditingController emailController;
  final void Function(String email, String password) onLogin;
  const AuthLoginComponent({required this.onLogin, required this.emailController, super.key});

  @override
  State<AuthLoginComponent> createState() => _AuthLoginComponentState();
}

class _AuthLoginComponentState extends State<AuthLoginComponent> {
  String _password = '';

  void _onSubmit({required String email, required String password}) {
    widget.onLogin(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CwTextFormFild(label: context.i18n.email, controller: widget.emailController, textCapitalization: TextCapitalization.none, maskUtils: MaskUtils.email(isRequired: true)),
        CwTextFormFild(
          textCapitalization: TextCapitalization.none,
          label: context.i18n.senha,
          maskUtils: MaskUtils.password(),
          obscureText: true,
          onChanged: (value) => _password = value,
          onFieldSubmitted: (value) => _onSubmit(email: widget.emailController.text, password: _password),
        ),
        PSize.iii.sizedBoxH,
        Row(children: [Expanded(child: ArtButton(onPressed: () => _onSubmit(email: widget.emailController.text, password: _password), child: Text(context.i18n.entrar)))]),
      ],
    );
  }
}
