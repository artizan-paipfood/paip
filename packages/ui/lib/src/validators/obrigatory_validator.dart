import 'package:ui/i18n/gen/strings.g.dart';
import 'package:ui/src/validators/validator_extension.dart';
import 'package:ui/ui.dart';

class ObrigatoryValidator extends FormController {
  @override
  String? Function(String? value)? get validator => (value) {
        if (value.vIsEmpty()) {
          return t.campo_obrigatorio;
        }
        return null;
      };
}
