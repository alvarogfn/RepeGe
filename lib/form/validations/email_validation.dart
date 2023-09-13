import 'package:email_validator/email_validator.dart';
import 'package:repege/form/validations/validations.dart';

class EmailValidation extends Validation {
  EmailValidation({super.message = 'Esse email é inválido.'});

  @override
  bool validate(String? value) {
    if (!production) return true;

    return EmailValidator.validate(value!);
  }
}
