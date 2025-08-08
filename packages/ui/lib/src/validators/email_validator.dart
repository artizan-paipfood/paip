import 'package:flutter/material.dart';
import 'package:artizan_ui/artizan_ui.dart';
import 'package:ui/src/.i18n/gen/strings.g.dart';

class EmailValidator extends FormController {
  final bool isRequired;
  final String? Function(String value)? customValidator;

  EmailValidator({required this.isRequired, this.customValidator});

  @override
  TextInputType? get textInputType => TextInputType.emailAddress;

  @override
  String? Function(String? value)? get validator => (value) {
    if (isRequired && FormController.isEmpty(value)) {
      return t.campo_obrigatorio;
    }
    if (FormController.isEmpty(value) == false && _isValid(value!) == false) return t.email_invalido;
    if (customValidator != null) {
      final String? text = customValidator!(value!);
      if (text != null) {
        return text;
      }
    }
    return null;
  };

  bool _isValid(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }
}

  // static MaskInputController email({required bool isRequired, String? Function(String value)? customValidate, bool isFinal = false}) {
  //   FocusNode? focusNode;
  //   bool isValidEmail(String email) {
  //     final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  //     return emailRegex.hasMatch(email);
  //   }

  //   return MaskInputController(
  //     keyboardType: TextInputType.emailAddress,
  //     getFocusNode: () {
  //       focusNode = focusNode ?? FocusNode();
  //       return focusNode!;
  //     },
  //     validator: (value) {
  //       String? isError;
  //       if (isRequired) {
  //         if (_isEmpty(value)) {
  //           isError = "E-mail obrigatório.";
  //         }
  //       }
  //       if (value != null && value.isNotEmpty) {
  //         if (!isValidEmail(value)) {
  //           isError = "E-mail inválido";
  //         }
  //         if (customValidate != null) {
  //           final String? text = customValidate.call(value);
  //           if (text != null) {
  //             isError = text;
  //           }
  //         }
  //       }
  //       requestFocusOnError(isError: isError, focusNode: focusNode);
  //       return isError;
  //     },
  //   );
  // }