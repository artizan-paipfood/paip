import 'package:artizan_ui/artizan_ui.dart';
import 'package:ui/ui.dart';

class CpfCnpjValidator extends FormController {
  @override
  List<String> get formaters => ['###.###.###-##', '##.###.###/####-##'];

  @override
  String? Function(String? value)? get validator => (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório';
        }
        if (value.length > 15 && CnpjValidator.isValidCnpj(value)) {
          return 'CNPJ inválido';
        }
        if (value.length < 15 && CpfValidator.isValidCpf(value)) {
          return 'CPF inválido';
        }
        return null;
      };
}
