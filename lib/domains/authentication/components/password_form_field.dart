import "package:flutter/material.dart";
import "package:repege/icons/octicons_icons.dart";
import "package:repege/utils/validations/password_validation.dart";
import "package:repege/utils/validations/required_validation.dart";
import "package:repege/utils/validations/validations.dart";

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    required this.label,
    this.action = TextInputAction.done,
    this.validation,
    required this.controller,
    super.key,
    this.helperText,
  });

  final TextEditingController controller;
  final TextInputAction action;
  final String label;
  final String? helperText;
  final String? Function(String?)? validation;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _isObscure = true;

  void toggle() => setState(() => _isObscure = !_isObscure);

  Color get primaryColor => Theme.of(context).colorScheme.primary;

  Icon get eye_icon {
    if (_isObscure) {
      return Icon(Octicons.eye, size: 19, color: primaryColor);
    }
    return Icon(Octicons.eye_closed, size: 19, color: primaryColor);
  }

  String? validator(String? value) {
    final result = Validator.validateWith(value, [
      RequiredValidation(),
      PasswordValidation(),
    ]);
    if (widget.validation != null) return widget.validation!(value) ?? result;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.label,
          prefixIcon: const Icon(Icons.password),
          suffix: GestureDetector(
            onTap: toggle,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: eye_icon,
            ),
          ),
        ),
        validator: validator,
        textInputAction: widget.action,
        obscureText: _isObscure,
      ),
    );
  }
}
