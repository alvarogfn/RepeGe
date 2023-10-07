import 'package:repege/core/utils/validations/validations.dart';

class AlphanumValidation extends Validation {
  AlphanumValidation({super.message = 'Apenas caracteres alfanúmericos são permitidos.'});

  @override
  bool validate(String? value) {
    if (value == null || value.isEmpty) return false;
    RegExp regexp = RegExp(r'^[a-zA-Z0-9]+$');
    return regexp.hasMatch(value);
  }
}
