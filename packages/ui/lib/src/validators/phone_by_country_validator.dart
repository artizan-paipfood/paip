/*
static MaskInputController phone({
    required TextEditingController textEditingController,
    required String locale,
    bool isRequired = false,
  }) {
    final selectedCountry = Countries.countriesAllowOnboarding.firstWhereOrNull((country) => country.locale == locale);

    final maskFormatter = [
      MaskTextInputFormatter(mask: selectedCountry?.maskMin ?? "########################"),
    ];

    FocusNode? focusNode;
    return MaskInputController(
      getFocusNode: () {
        focusNode = focusNode ?? FocusNode();
        return focusNode;
      },
      onlenghtMaskChange: selectedCountry?.minLength,
      inpuFormatters: maskFormatter,
      onChanged: (value) {
        final lenght = value.length;
        if (lenght <= (selectedCountry?.maskMin?.length ?? 1000)) {
          textEditingController.value = maskFormatter[0].updateMask(mask: selectedCountry?.maskMin);
        }
        if (value.length == (selectedCountry?.maskMax?.length ?? 100) - 1) {
          textEditingController.value = maskFormatter[0].updateMask(mask: selectedCountry?.maskMax);
        }
      },
      hint: selectedCountry?.maskMin?.replaceAll("#", "0") ?? "0000 0000000",
      keyboardType: TextInputType.number,
      autovalidateMode: isRequired ? AutovalidateMode.onUserInteraction : null,
      validator: (value) {
        String? isError;
        if (_isEmpty(value) && isRequired) {
          isError = "Telefone obrigatório.";
        }
        if ((Utils.onlyNumbersRgx(value!).length > 1) && (Utils.onlyNumbersRgx(value).length < (selectedCountry?.minLength ?? 4))) {
          isError = "Telefone incompleto";
        }

        requestFocusOnError(isError: isError, focusNode: focusNode);
        return isError;
      },
    );
  }
*/

import 'package:artizan_ui/artizan_ui.dart';
import 'package:flutter/material.dart';

class PhoneByCountryValidator extends FormController {
  final List<String> masks;
  final bool isRequired;
  final int minLenght;
  PhoneByCountryValidator({
    required this.masks,
    required this.isRequired,
    required this.minLenght,
  });
  @override
  List<String> get formaters => masks;

  @override
  String? Function(String? value)? get validator => (value) {
        if (FormController.isEmpty(value) && isRequired) {
          return 'Telefone obrigatório.';
        }
        if (FormController.isEmpty(value) && isRequired == false) {
          return null;
        }
        if ((value!.length > 1) && (value.length < minLenght)) {
          return 'Telefone incompleto';
        }
        return null;
      };

  @override
  RegExp get regexFilter => RegExp(r'[0-9]');

  @override
  TextInputType? get textInputType => TextInputType.number;
}
