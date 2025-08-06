import 'package:flutter/widgets.dart';
import 'package:ui/i18n/gen/strings.g.dart';
import 'package:ui/src/validators/validator_extension.dart';
import 'package:ui/ui.dart';

class CepValidator extends FormController {
  final bool isRequired;

  CepValidator({this.isRequired = false});

  @override
  String? Function(String? value)? get validator => (value) {
        if (isRequired && value.vIsEmpty()) {
          return t.campo_obrigatorio;
        }

        if (value.vIsNotEmpty() && !value.vIsValidCEP()) {
          return t.cep_invalido;
        }
        return null;
      };

  @override
  RegExp get regexFilter => RegExp(r'^[0-9\s-]*$');

  @override
  TextInputType? get textInputType => TextInputType.number;

  @override
  List<String> get formaters => ['#####-###'];
}
