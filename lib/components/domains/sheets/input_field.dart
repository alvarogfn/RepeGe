import 'package:flutter/material.dart';
import 'package:repege/utils/if_prop.dart';

import '../../../utils/validations/required_validation.dart';
import '../../../utils/validations/validations.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.initialValue,
    required this.propertyKey,
    required this.label,
    required this.editMode,
    required this.updateSheetField,
    super.key,
  });

  final String initialValue;
  final String propertyKey;
  final String label;
  final bool editMode;
  final void Function(String, String) updateSheetField;

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).colorScheme.primary;

    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 18,
          color: primary,
        ),
        suffixIcon: ifProp(
          editMode,
          Icon(Icons.edit, size: 17, color: primary.withAlpha(200)),
        ),
        border: ifPropElse(
          editMode,
          const UnderlineInputBorder(),
          InputBorder.none,
        ),
      ),
      onFieldSubmitted: (value) => updateSheetField('characterName', value),
      validator: (value) => Validator.validateWith(value, [
        RequiredValidation(),
      ]),
      readOnly: !editMode,
      textInputAction: TextInputAction.done,
    );
  }
}
