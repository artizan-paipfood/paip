import 'package:artizan_ui/artizan_ui.dart';

class ObrigatoryValidator extends FormController {
  @override
  String? Function(String? value)? get validator => (value) {
        if (FormController.isEmpty(value)) {
          return 'Campo obrigatório';
        }
        return null;
      };
}
