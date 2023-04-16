import 'package:repege/utils/validations/validations.dart';

class PasswordValidation extends Validation {
  PasswordValidation({
    super.message =
        'Use 8+ caracteres, letras maiúsculas/minúsculas e 1+ dígito. Evite informações pessoais.',
  });

  @override
  bool validate(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    if (value.length < 8) {
      return false;
    }

    bool hasUppercase = false;
    for (int i = 0; i < value.length; i++) {
      if (value[i].toUpperCase() == value[i]) {
        hasUppercase = true;
        break;
      }
    }
    if (!hasUppercase) {
      return false;
    }

    bool hasLowercase = false;
    for (int i = 0; i < value.length; i++) {
      if (value[i].toLowerCase() == value[i]) {
        hasLowercase = true;
        break;
      }
    }
    if (!hasLowercase) {
      return false;
    }

    bool hasDigit = false;
    for (int i = 0; i < value.length; i++) {
      if (double.tryParse(value[i]) != null) {
        hasDigit = true;
        break;
      }
    }
    if (!hasDigit) {
      return false;
    }

    return true;
  }
}
