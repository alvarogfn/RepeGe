import 'package:repege/modules/shared/utils/validations/validations.dart';

class RequiredValidation extends Validation {
  RequiredValidation({super.message = 'Esse campo é obrigatório.'});

  @override
  bool validate(String? value) {
    return value is String && value.trim().isNotEmpty;
  }
}
