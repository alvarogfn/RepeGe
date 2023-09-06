import 'package:flutter/material.dart';
import 'package:repege/utils/validations/required_validation.dart';
import 'package:repege/utils/validations/validations.dart';

class EquipmentFormField extends StatelessWidget {
  const EquipmentFormField({
    required this.labelText,
    required this.onChanged,
    this.maxLines = 1,
    this.hintText,
    this.initialValue,
    this.textInputAction = TextInputAction.next,
    this.margin = const EdgeInsets.symmetric(vertical: 10),
    this.keyboardType = TextInputType.text,
    super.key,
  });

  final String labelText;
  final String? hintText;
  final String? initialValue;
  final Function(String value) onChanged;
  final EdgeInsets margin;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        onChanged: onChanged,
        validator: (value) => Validator.validateWith(value, [
          RequiredValidation(),
        ]),
        maxLines: maxLines,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
      ),
    );
  }
}
