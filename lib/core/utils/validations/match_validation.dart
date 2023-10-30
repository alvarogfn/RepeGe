import 'package:repege/core/utils/validations/validations.dart';

class MatchValidation extends Validation {
  final String matchText;
  final bool toMatch;

  MatchValidation({required super.message, required this.matchText, this.toMatch = true});

  @override
  bool validate(String? value) {
    if (value == null) return true;
    if (value.toLowerCase() == matchText.toLowerCase() && !toMatch) return true;
    if (value.toLowerCase() != matchText.toLowerCase() && toMatch) return true;

    return false;
  }
}
