import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ValidatePasswordWidget extends StatelessWidget {
  final String password;
  final String confirmPassword;
  const ValidatePasswordWidget({
    super.key,
    this.password = '',
    this.confirmPassword = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Para ter uma senha forte sua senha deve conter:"),
        Wrap(
          spacing: 8,
          children: [
            _buildRow("Minímo 6 caracteres", check: password.length >= 6),
            _buildRow("Letra maiuscula", check: Utils.rgxHasMatch(RegExp(r'[A-Z]'), value: password)),
            _buildRow("Letra minuscula", check: Utils.rgxHasMatch(RegExp(r'[a-z]'), value: password)),
            _buildRow("Numero", check: Utils.rgxHasMatch(RegExp(r'\d'), value: password)),
            _buildRow("Símbolo", check: Utils.rgxHasMatch(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'), value: password)),
            _buildRow("Senhas coencidem", check: (password.isNotEmpty && password == confirmPassword)),
          ],
        ),
      ],
    );
  }

  Widget _buildRow(String text, {required bool check}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        check
            ? Icon(PIcons.strokeRoundedCheckmarkCircle01, size: 16, color: PColors.light.primaryColor) //
            : const Icon(PIcons.strokeRoundedInformationCircle, size: 16),
        PSize.i.sizedBoxW,
        Text(
          text,
        ),
      ],
    );
  }
}
