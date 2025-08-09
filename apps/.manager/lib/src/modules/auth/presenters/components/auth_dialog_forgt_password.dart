import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AuthDialogForgotPassword extends StatefulWidget {
  final String? email;
  final Function(String email) onSubmit;
  const AuthDialogForgotPassword({required this.onSubmit, super.key, this.email});

  @override
  State<AuthDialogForgotPassword> createState() => _AuthDialogForgotPasswordState();
}

class _AuthDialogForgotPasswordState extends State<AuthDialogForgotPassword> {
  late String _email = widget.email ?? '';
  @override
  Widget build(BuildContext context) {
    return CwDialog(
      title: Text('Recuperar senha'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Text('Informe o email cadastrado, para enviarmos um link para redefinição da senha.', style: context.textTheme.bodyMedium?.copyWith(color: context.color.muted)), CwTextFormFild(label: "Email", initialValue: _email, onChanged: (value) => _email = value)],
      ),
      actions: [
        Row(children: [Expanded(child: PButton(label: context.i18n.confirmar.toUpperCase(), onPressed: () => widget.onSubmit(_email)))]),
      ],
    );
  }
}
