import 'package:ui/ui.dart';
import 'package:ui/i18n/gen/strings.g.dart';

class CpfCnpjValidator extends FormController {
  @override
  List<String> get formaters => ['###.###.###-##', '##.###.###/####-##'];

  @override
  String? Function(String? value)? get validator => (value) {
        if (value == null || value.isEmpty) {
          return t.campo_obrigatorio;
        }
        if (value.length > 15 && CnpjValidator.isValidCnpj(value)) {
          return t.cnpj_invalido;
        }
        if (value.length < 15 && CpfValidator.isValidCpf(value)) {
          return t.cpf_invalido;
        }
        return null;
      };
}
