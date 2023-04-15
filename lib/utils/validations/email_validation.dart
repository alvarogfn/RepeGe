import 'package:email_validator/email_validator.dart';
import 'package:tcc/utils/validations/validations.dart';

class EmailValidation extends Validation {
  EmailValidation({super.message = 'Esse email é inválido.'});

  @override
  bool validate(String? value) {
    return EmailValidator.validate(value!);
  }
}
