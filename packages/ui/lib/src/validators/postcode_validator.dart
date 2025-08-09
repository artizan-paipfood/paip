import 'package:flutter/src/services/text_input.dart';
import 'package:ui/src/_i18n/gen/strings.g.dart';
import 'package:ui/src/validators/validator_extension.dart';
import 'package:ui/ui.dart';

class PostCodeValidator extends FormController {
  final bool isRequired;

  PostCodeValidator({this.isRequired = false});

  @override
  String? Function(String? value)? get validator => (value) {
    if (isRequired && value.vIsEmpty()) {
      return t.campo_obrigatorio;
    }

    if (value.vIsNotEmpty() && !value.vIsValidPostCode()) {
      return t.cep_invalido;
    }
    return null;
  };

  @override
  RegExp get regexFilter => RegExp(r'^[0-9\s-]*$');

  @override
  TextInputType? get textInputType => TextInputType.number;
}
