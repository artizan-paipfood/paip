import 'package:flutter/material.dart';
import 'package:artizan_ui/artizan_ui.dart';
import 'package:ui/i18n/gen/strings.g.dart';

class CpfValidator extends FormController {
  final bool isRequired;
  CpfValidator({
    required this.isRequired,
  });

  @override
  String? Function(String? value)? get validator => (value) {
        if (isRequired && FormController.isEmpty(value)) {
          return t.campo_obrigatorio;
        }
        if (!isValidCpf(value!)) {
          return t.cpf_invalido;
        }
        return null;
      };

  @override
  TextInputType? get textInputType => TextInputType.number;

  @override
  List<String> get formaters => ['###.###.###-##'];

  static bool isValidCpf(String cpf) {
    // Remover caracteres não numéricos
    cpf = cpf.replaceAll(RegExp(r'\D'), '');
    // Verificar se possui 11 dígitos
    if (cpf.length != 11) {
      return false;
    }
    // Verificar se todos os dígitos são iguais (caso contrário, é inválido)
    if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) {
      return false;
    }
    // Calcular o primeiro dígito verificador
    var soma = 0;
    for (var i = 0; i < 9; i++) {
      soma += int.parse(cpf[i]) * (10 - i);
    }
    var digito1 = (soma * 10) % 11;
    if (digito1 == 10) {
      digito1 = 0;
    }
    // Verificar o primeiro dígito verificador
    if (digito1 != int.parse(cpf[9])) {
      return false;
    }
    // Calcular o segundo dígito verificador
    soma = 0;
    for (var i = 0; i < 10; i++) {
      soma += int.parse(cpf[i]) * (11 - i);
    }
    var digito2 = (soma * 10) % 11;
    if (digito2 == 10) {
      digito2 = 0;
    }
    // Verificar o segundo dígito verificador
    if (digito2 != int.parse(cpf[10])) {
      return false;
    }
    // CPF válido
    return true;
  }
}
