import 'package:artizan_ui/artizan_ui.dart';
import 'package:ui/src/.i18n/gen/strings.g.dart';

class PasswordValidator extends FormController {
  final String? Function(String value)? customValidator;
  PasswordValidator({this.customValidator});
  @override
  String? Function(String? value)? get validator => (value) {
    if (FormController.isEmpty(value)) {
      return t.campo_obrigatorio;
    }
    if (value!.length < 8) {
      return t.senha_invalida_minimo_caracteres;
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
