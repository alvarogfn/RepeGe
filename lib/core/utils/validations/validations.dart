import 'package:repege/core/config/environment_variables.dart';

abstract class Validation {
  final String message;
  final bool production;
  const Validation({
    this.message = '',
    this.production = EnvironmentVariables.production,
  });

  bool validate(String? value) {
    return true;
  }
}

class Validator {
  static String? validateWith(String? value, List<Validation> validations) {
    try {
      return validations.firstWhere((validation) {
        return !validation.validate(value);
      }).message;
    } on StateError {
      return null;
    }
  }
}
