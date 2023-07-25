import 'package:flutter/material.dart';
import 'package:repege/modules/shared/utils/validations/validations.dart';

class SheetTextField extends StatelessWidget {
  const SheetTextField({
    super.key,
    this.validations = const [],
    this.label,
    this.placeholder,
    this.initialValue,
    this.helperText,
    this.onChanged,
    this.margin = const EdgeInsets.all(0),
    this.action = TextInputAction.done,
    this.prefixIcon,
    this.maxLines = 1,
    this.controller,
    this.readOnly = false,
  });

  final TextEditingController? controller;
  final bool readOnly;
  final List<Validation> validations;
  final String? label;
  final String? initialValue;
  final String? helperText;
  final String? placeholder;
  final TextInputAction action;
  final int maxLines;
  final EdgeInsets margin;
  final IconData? prefixIcon;
  final void Function(String?)? onChanged;

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
          helperText: helperText,
          hintText: placeholder,
        ),
        maxLines: maxLines,
        onChanged: onChanged,
        textInputAction: action,
        readOnly: readOnly,
      ),
    );
  }
}
