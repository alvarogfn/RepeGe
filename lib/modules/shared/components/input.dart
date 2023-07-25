import 'package:flutter/material.dart';
import 'package:repege/modules/shared/utils/validations/validations.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    this.validations = const [],
    this.label,
    this.placeholder,
    this.initialValue,
    this.helperText,
    this.onChanged,
    this.obscure = false,
    this.margin = const EdgeInsets.all(0),
    this.action = TextInputAction.done,
    this.prefixIcon,
    this.maxLines = 1,
    this.suffixIcon,
    this.suffix,
    this.validateFn,
    this.controller,
    this.validateMode = AutovalidateMode.disabled,
    this.readOnly = false,
  });

  final TextEditingController? controller;
  final AutovalidateMode validateMode;
  final bool readOnly;
  final String? Function(String?)? validateFn;
  final List<Validation> validations;
  final String? label;
  final String? initialValue;
  final String? helperText;
  final String? placeholder;
  final TextInputAction action;
  final int maxLines;
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
        controller: controller,
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
          suffix: suffix,
          helperText: helperText,
          hintText: placeholder,
        ),
        maxLines: maxLines,
        validator: validator,
        onChanged: onChanged,
        textInputAction: action,
        obscureText: obscure,
        readOnly: readOnly,
        autovalidateMode: validateMode,
      ),
    );
  }
}