import 'package:artizan_ui/artizan_ui.dart';

class PasswordValidator extends FormController {
  final String? Function(String value)? customValidator;
  PasswordValidator({
    this.customValidator,
  });
  @override
  String? Function(String? value)? get validator => (value) {
        if (FormController.isEmpty(value)) {
          return 'Senha obrigatória';
        }
        if (value!.length < 8) {
          return 'Senha deve ter no mínimo 8 caracteres';
        }
        if (customValidator != null) {
          final String? text = customValidator!(value);
          if (text != null) {
            return text;
          }
        }
        return null;
      };
}
