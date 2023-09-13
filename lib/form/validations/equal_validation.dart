import 'package:repege/form/validations/validations.dart';

class EqualValidation extends Validation {
  final String value;

  EqualValidation({
    required this.value,
    super.message = '',
  });

  @override
  bool validate(String? value) {
    return value != null && this.value == value;
  }
}
