import "package:flutter/material.dart";
import "package:repege/components/atoms/input.dart";
import "package:repege/icons/octicons_icons.dart";
import "package:repege/utils/validations/password_validation.dart";
import "package:repege/utils/validations/required_validation.dart";
import "package:repege/utils/validations/validations.dart";

class InputPassword extends StatefulWidget {
  const InputPassword({
    required this.label,
    super.key,
    this.initialValue,
    this.placeholder,
    this.action = TextInputAction.done,
    this.margin = const EdgeInsets.all(0),
    this.onChanged,
    this.validation,
    this.validateFn,
    this.controller,
  });

  final TextEditingController? controller;
  final TextInputAction action;
  final String? initialValue;
  final String label;
  final EdgeInsets margin;
  final Function(String?)? onChanged;
  final String? placeholder;
  final Validation? validation;
  final String? Function(String?)? validateFn;

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool _isObscure = true;

  void toggle() => setState(() => _isObscure = !_isObscure);

  Color get primaryColor => Theme.of(context).colorScheme.primary;

  Icon get icon {
    if (_isObscure) {
      return Icon(Octicons.eye, size: 19, color: primaryColor);
    }
    return Icon(Octicons.eye_closed, size: 19, color: primaryColor);
  }

  @override
  Widget build(BuildContext context) {
    return Input(
      action: widget.action,
      initialValue: widget.initialValue,
      label: widget.label,
      margin: widget.margin,
      onChanged: widget.onChanged,
      placeholder: widget.placeholder,
      prefixIcon: Icons.password,
      obscure: _isObscure,
      controller: widget.controller,
      suffix: GestureDetector(
        onTap: toggle,
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: icon,
        ),
      ),
      validations: [
        RequiredValidation(),
        PasswordValidation(),
      ],
      validateFn: widget.validateFn,
    );
  }
}
