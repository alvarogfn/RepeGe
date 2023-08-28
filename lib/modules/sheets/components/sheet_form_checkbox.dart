import 'package:flutter/material.dart';

class SheetFormCheckBox extends StatelessWidget {
  const SheetFormCheckBox({
    this.labelText = '',
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String labelText;
  final bool value;
  final void Function(bool? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: value,
            onChanged: (value) => onChanged(value ?? false),
          ),
          Text(labelText),
        ],
      ),
    );
  }
}
