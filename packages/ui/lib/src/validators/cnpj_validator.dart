import 'package:artizan_ui/artizan_ui.dart';
import 'package:flutter/material.dart';
import 'package:ui/i18n/gen/strings.g.dart';

class CnpjValidator extends FormController {
  final bool isRequired;
  CnpjValidator({
    required this.isRequired,
  });

  @override
  String? Function(String? value)? get validator => (value) {
        if (isRequired && FormController.isEmpty(value)) {
          return t.campo_obrigatorio;
        }
        if (!isValidCnpj(value!)) {
          return t.cnpj_invalido;
        }
        return null;
      };

  @override
  TextInputType? get textInputType => TextInputType.number;

  @override
  RegExp get regexFilter => RegExp(r'[0-9./-]');

  /// A string mask to format input strings.
  @override
  List<String> get formaters => ['##.###.###/####-##'];

  static bool isValidCnpj(String cnpj) {
    // Remover caracteres não numéricos
    cnpj = cnpj.replaceAll(RegExp(r'\D'), '');
    // Verificar se possui 14 dígitos
    if (cnpj.length != 14) {
      return false;
    }
    // Verificar se todos os dígitos são iguais (caso contrário, é inválido)
    if (RegExp(r'^(\d)\1*$').hasMatch(cnpj)) {
      return false;
    }
    // Calcular o primeiro dígito verificador
    var soma = 0;
    var peso = 5;
    for (var i = 0; i < 12; i++) {
      soma += int.parse(cnpj[i]) * peso;
      peso = (peso == 2) ? 9 : peso - 1;
    }
    final digito1 = (11 - (soma % 11)) % 10;
    // Calcular o segundo dígito verificador
    soma = 0;
    peso = 6;
    for (var i = 0; i < 13; i++) {
      soma += int.parse(cnpj[i]) * peso;
      peso = (peso == 2) ? 9 : peso - 1;
    }
    final digito2 = (11 - (soma % 11)) % 10;
    // Verificar se os dígitos calculados correspondem aos dígitos informados
    return digito1 == int.parse(cnpj[12]) && digito2 == int.parse(cnpj[13]);
  }
}
