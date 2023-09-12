import 'package:repege/utils/validations/validations.dart';

class UsernameValidation extends Validation {
  UsernameValidation({super.message = 'Esse nome de usuário não é válido.'});

  @override
  bool validate(String? value) {
    if (!production) return true;

    if (value == null || value.isEmpty) return false;

    return true;
  }
}
