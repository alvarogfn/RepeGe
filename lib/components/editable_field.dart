import 'package:flutter/material.dart';

class EditableField extends StatelessWidget {
  const EditableField({
    required this.onSubmit,
    required this.value,
    required this.label,
    super.key,
  });

  final Function onSubmit;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        Text(value),
      ],
    );
  }
}
