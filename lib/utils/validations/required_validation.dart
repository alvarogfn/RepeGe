import 'package:tcc/utils/validations/validations.dart';

class RequiredValidation extends Validation {
  RequiredValidation({super.message = 'Esse campo é obrigátorio.'});

  @override
  bool validate(String? value) {
    return value is String && value.trim().isNotEmpty;
  }
}
