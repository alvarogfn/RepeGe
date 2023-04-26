import 'package:flutter/material.dart';

class EditableFormField extends StatelessWidget {
  const EditableFormField({
    required this.initialValue,
    required this.labelText,
    required this.readOnly,
    this.onSubmited,
    super.key,
  });

  final String initialValue;
  final String labelText;
  final bool readOnly;
  final void Function(String)? onSubmited;

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).colorScheme.primary;

    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 18,
          color: primary,
        ),
        border: InputBorder.none,
        suffix: readOnly
            ? Icon(
                Icons.edit,
                size: 17,
                color: primary.withAlpha(200),
              )
            : null,
      ),
      style: const TextStyle(),
      readOnly: readOnly,
      onFieldSubmitted: onSubmited,
    );
  }
}
