import 'package:flutter/material.dart';
import 'package:repege/utils/validations/validations.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    this.validations = const [],
    this.label = '',
    this.placeholder = '',
    this.initialValue = '',
    this.helperText,
    this.onChanged,
    this.obscure = false,
    this.margin = const EdgeInsets.all(0),
    this.action = TextInputAction.done,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.validateFn,
  });

  final String? Function(String?)? validateFn;
  final List<Validation> validations;
  final String label;
  final String initialValue;
  final String? helperText;
  final String placeholder;
  final TextInputAction action;
  final EdgeInsets margin;
  final bool obscure;
  final Widget? suffix;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final void Function(String?)? onChanged;

  String? validator(String? value) {
    if (validateFn == null) {
      return Validator.validateWith(value, validations);
    }

    return validateFn!(value) ?? Validator.validateWith(value, validations);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
          suffix: suffix,
          helperText: helperText,
          hintText: placeholder,
        ),
        validator: validator,
        onChanged: onChanged,
        textInputAction: action,
        obscureText: obscure,
      ),
    );
  }
}
