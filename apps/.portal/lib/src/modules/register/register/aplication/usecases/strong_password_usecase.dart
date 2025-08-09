import 'package:paipfood_package/paipfood_package.dart';
import '../../domain/dtos/password_validation_dto.dart';

class StrongPasswordUsecase {
  PasswordValidationDto call(String password) {
    var validator = PasswordValidationDto();

    if (RegExp(r'[A-Z]').hasMatch(password)) {
      validator.score += 0.25;
    }
    if (RegExp(r'[0-9]').hasMatch(password)) {
      validator.score += 0.25;
    }
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      validator.score += 0.25;
    }
    validator.score += 0.25;
    if (validator.score == 0.5) {
      validator.color = PColors.light.tertiaryColor;
      validator.description = "Senha Média - min 8 caracteres";
    } else if (validator.score == 0.75) {
      validator.color = PColors.light.secondaryColor;
      validator.description = "Senha Forte - min 8 caracteres";
    } else if (validator.score == 1) {
      validator.color = PColors.light.primaryColor;
      validator.description = "Senha Perfeita";
    } else {
      validator.color = PColors.light.errorColor;
      validator.description = "Senha fraca - min 8 caracteres";
    }
    return validator;
  }
}
