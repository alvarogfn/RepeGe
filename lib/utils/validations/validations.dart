abstract class Validation {
  final String message;
  const Validation({this.message = ''});

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
